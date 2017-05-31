# converted to Crystal from http://xorshift.di.unimi.it/xorshift1024star.c
#
# Original implementation: Written in 2014 by Sebastiano Vigna (vigna@acm.org)

# xorshift1024+
#       -  result:      64-bit unsigned int
#       -  period:      2^1024-1
#       -  state type:  1025 bytes
class Random::Xorshift1024star
  include Random

  @s : UInt64[16]
  @p : Int32

  def initialize(@s)
    @p = 0
  end

  def initialize(seed : UInt64 = UInt64.new(Random.new_seed))
    @p = 0
    @s = init_by_seed(seed)
  end

  def new_seed(@s)
    @p = 0
  end

  def new_seed(seed : UInt64 = UInt64.new(Random.new_seed))
    @p = 0
    @s = init_by_seed(seed)
  end

  # using splitmix64 for seeding as suggested in original implementation
  # Original implementation: Written in 2015 by Sebastiano Vigna (vigna@acm.org)
  # http://xoroshiro.di.unimi.it/splitmix64.c
  private def init_by_seed(seed : UInt64)
    StaticArray(UInt64, 16).new do |i|
      seed += 0x9E3779B97F4A7C15_u64
      z = seed
      z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9_u64
      z = (z ^ (z >> 27)) * 0x94D049BB133111EB_u64
      z ^ (z >> 31)
    end
  end

  def next_u
    s0 = @s[@p]
    @p = (@p + 1) & 15
    s1 = @s[@p]
    s1 ^= s1 << 31                             # a
    @s[@p] = s1 ^ s0 ^ (s1 >> 11) ^ (s0 >> 30) # b,c
    return @s[@p] * 1181783497276652981_u64
  end
end

# converted to Crystal from http://xoroshiro.di.unimi.it/xoroshiro128plus.c
#
# Original implementation: Written in 2016 by David Blackman and Sebastiano Vigna (vigna@acm.org)

# xoroshiro128+
#       -  result:      64-bit unsigned int
#       -  period:      2^128-1
#       -  state type:  8 bytes
class Random::Xoroshiro128plus
  include Random

  @s : UInt64[2]

  def initialize(@s)
  end

  def initialize(seed : UInt64 = UInt64.new(Random.new_seed))
    @s = init_by_seed(seed)
  end

  def new_seed(@s)
  end

  def new_seed(seed : UInt64 = UInt64.new(Random.new_seed))
    @s = init_by_seed(seed)
  end

  # using splitmix64 for seeding as suggested in original implementation
  # Original implementation: Written in 2015 by Sebastiano Vigna (vigna@acm.org)
  # http://xoroshiro.di.unimi.it/splitmix64.c
  private def init_by_seed(seed : UInt64)
    StaticArray(UInt64, 2).new do |i|
      seed += 0x9E3779B97F4A7C15_u64
      z = seed
      z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9_u64
      z = (z ^ (z >> 27)) * 0x94D049BB133111EB_u64
      z ^ (z >> 31)
    end
  end

  @[AlwaysInline]
  private def rotl(x : UInt64, k)
    (x << k) | (x >> (64 - k))
  end

  def next_u
    s0 = @s[0]
    s1 = @s[1]
    result = s0 + s1

    s1 ^= s0
    @s[0] = rotl(s0, 55) ^ s1 ^ (s1 << 14) # a, b
    @s[1] = rotl(s1, 36)                   # c

    return result
  end
end
