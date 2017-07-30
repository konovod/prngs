require "secure_random"

# Crystal implementation of ChaCha12/20 PRNG.
# Algorithm is considered cryptographically secure, but is relatively slow and
# (as any user-space algorithm) is prone to side-channel attacks -
# so must not be used as a SecureRandom replacement, only as a Random,
# just not predictable by it's output
class Random::ChaCha(Rounds)
  include Random

  BUF_SIZE = 16
  @decrypted = StaticArray(UInt32, BUF_SIZE).new { 0_u32 }
  @encrypted = StaticArray(UInt32, BUF_SIZE).new { 0_u32 }
  @pool_index : Int32 = 0
  @nonce : UInt64 = 0_u64
  @counter : UInt64 = 0_u64

  def initialize(key, nonce)
    new_seed StaticArray(UInt32, 8).new { |i| key[i] }, nonce
  end

  def new_seed(key, nonce)
    @counter = 0_u64
    @nonce = nonce
    @stream_id = 0_u64
    init_buffer(key)
    chacha
    @pool_index = 0
  end

  # for easier seeding
  def initialize(seed : UInt64)
    new_seed seed
  end

  def new_seed(seed : UInt64)
    new_seed(StaticArray(UInt32, 8).new do |i|
      i < 2 ? (seed >> (i*32)).to_u32 : 0_u32
    end, 0_u64)
  end

  # for seeding from secure source
  def initialize
    new_seed
  end

  def new_seed
    # get bytes from SecureRandom and convert to UInt32 slice
    key = SecureRandom.random_bytes(4 * 10).to_unsafe.as(Pointer(UInt32)).to_slice(10)
    new_seed(StaticArray(UInt32, 8).new do |i|
      key[i]
    end, UInt64.new(key[8]) << 32 + key[9])
  end

  private def init_buffer(key : StaticArray(UInt32, 8))
    # "expand 32-byte k" as little endian uint32s.
    @decrypted[0] = 0x61707865_u32
    @decrypted[1] = 0x3320646e_u32
    @decrypted[2] = 0x79622d32_u32
    @decrypted[3] = 0x6b206574_u32
    # key
    8.times do |i|
      @decrypted[i + 4] = key[i]
    end
    # the rest is counter that will be filled in chacha
  end

  def next_u
    result = @encrypted[@pool_index]
    if (@pool_index += 1) >= BUF_SIZE
      @counter += 1
      chacha
      @pool_index = 0
    end
    result
  end

  @[AlwaysInline]
  private def rotl(x : UInt32, k)
    (x << k) | (x >> (32 - k))
  end

  @[AlwaysInline]
  private def quarterround(a, b, c, d)
    @encrypted[a] += @encrypted[b]; @encrypted[d] ^= @encrypted[a]; @encrypted[d] = rotl(@encrypted[d], 16)
    @encrypted[c] += @encrypted[d]; @encrypted[b] ^= @encrypted[c]; @encrypted[b] = rotl(@encrypted[b], 12)
    @encrypted[a] += @encrypted[b]; @encrypted[d] ^= @encrypted[a]; @encrypted[d] = rotl(@encrypted[d], 8)
    @encrypted[c] += @encrypted[d]; @encrypted[b] ^= @encrypted[c]; @encrypted[b] = rotl(@encrypted[b], 7)
  end

  private def chacha
    # init buffer
    @decrypted[12] = (@nonce >> 32).to_u32
    @decrypted[13] = (@nonce >> 0).to_u32
    @decrypted[14] = (@counter >> 32).to_u32
    @decrypted[15] = (@counter >> 0).to_u32

    @encrypted = @decrypted
    # Rounds rounds, 2 rounds per loop.
    (Rounds/2).times do
      quarterround(0, 4, 8, 12)  # column 0
      quarterround(1, 5, 9, 13)  # column 1
      quarterround(2, 6, 10, 14) # column 2
      quarterround(3, 7, 11, 15) # column 3
      quarterround(0, 5, 10, 15) # diagonal 1
      quarterround(1, 6, 11, 12) # diagonal 2
      quarterround(2, 7, 8, 13)  # diagonal 3
      quarterround(3, 4, 9, 14)  # diagonal 4
    end
    # add decrypted to encrypted
    BUF_SIZE.times do |i|
      @encrypted[i] += @decrypted[i]
    end
    # p @decrypted.to_slice.to_unsafe.as(UInt8*).to_slice(4*16).hexstring
    # p @encrypted.to_slice.to_unsafe.as(UInt8*).to_slice(4*16).hexstring
  end

  def jump(delta)
    partial = delta.abs % BUF_SIZE
    full = (delta.abs / BUF_SIZE)*delta.sign
    new_pool_index = @pool_index + delta.sign * partial
    if new_pool_index < 0
      new_pool_index += BUF_SIZE
      full -= 1
    elsif new_pool_index >= BUF_SIZE
      new_pool_index -= BUF_SIZE
      full += 1
    end
    if full != 0
      @counter += full
      chacha
    end
    @pool_index = new_pool_index
  end
end

module Random
  alias ChaCha12 = ChaCha(12)
  alias ChaCha20 = ChaCha(20)
end
