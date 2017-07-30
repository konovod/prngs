require "random"
require "secure_random"
require "benchmark"
require "./src/prngs"

gens = {
  Random::MT19937.new,
  Random::ISAAC.new,
  Random::ISAACPlus.new,
  Random::Xorshift1024star.new,
  Random::Xoroshiro128plus.new,
  Random::ShardPCG32.new,
  Random::WELL512.new,
  Random::ChaCha20.new,
  Random::ChaCha12.new,
}

x = 0.0 # to ensure that optimizations won't remove rand calls
bytes = Bytes.new(4)
Benchmark.ips do |bench|
  gens.each do |gen|
    bench.report(gen.class.to_s) { x += gen.rand }
  end
  bench.report("SecureRandom") { SecureRandom.random_bytes(bytes) }
end
p x
