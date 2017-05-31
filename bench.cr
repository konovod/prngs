require "random/isaac"
require "benchmark"
require "./src/prngs"

gens = {
  Random::MT19937.new,
  Random::ISAAC.new,
  Random::Xorshift1024star.new,
  Random::Xoroshiro128plus.new,
  Random::PCG32.new,
}

Benchmark.ips do |bench|
  gens.each do |gen|
    bench.report(gen.class.to_s) { gen.rand }
  end
end
