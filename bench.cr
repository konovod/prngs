require "random/isaac"
require "benchmark"
require "./src/prngs"

gens = {
  Random::MT19937.new,
  Random::ISAAC.new,
  Random::Xorshift1024star.new,
  Random::Xoroshiro128plus.new,
  Random::PCG32.new,
  Random::WELL512.new,
}

x = 0 # to ensure that optimizations won't remove rand calls
Benchmark.ips do |bench|
  gens.each do |gen|
    bench.report(gen.class.to_s) { x += gen.rand }
  end
end
p x
