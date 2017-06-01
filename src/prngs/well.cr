class Random::WELL512
  include Random

  @state : UInt32[16]
  @index : Int32

  def initialize(seeds : UInt32[16])
    # initialize to zeros to prevent compiler complains
    @state = seeds
    @index = 0
  end

  def new_seed(seeds : UInt32[16])
    # initialize to zeros to prevent compiler complains
    @state = seeds
    @index = 0
  end

  def initialize(seed : UInt64 = UInt64.new(Random.new_seed))
    @state = StaticArray(UInt32, 16).new do |i|
      seed += 0x9E3779B97F4A7C15_u64
      z = seed
      z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9_u64
      z = (z ^ (z >> 27)) * 0x94D049BB133111EB_u64
      UInt32.new(z ^ (z >> 31))
    end
    @index = 0
  end

  def next_u
    a = @state[@index]
    c = @state[(@index + 13) & 15]
    b = a ^ c ^ (a << 16) ^ (c << 15)
    c = @state[(@index + 9) & 15]
    c ^= (c >> 11)
    a = @state[@index] = b ^ c
    d = a ^ ((a << 5) & 0xDA442D24_u32)
    @index = (@index + 15) & 15
    a = @state[@index]
    @state[@index] = a ^ b ^ d ^ (a << 2) ^ (b << 18) ^ (c << 28)
    return @state[@index]
  end
end
