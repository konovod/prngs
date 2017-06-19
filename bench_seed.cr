require "secure_random"
require "benchmark"
require "./src/prngs/pcg"

seed = Slice(UInt64).new(2)
bytes = seed.to_unsafe.as(UInt8*).to_slice(2*sizeof(UInt64))

Benchmark.ips do |bench|
  bench.report("time") { Random.new_seed }
  bench.report("SecureRandom") { SecureRandom.random_bytes(bytes) }
end

Benchmark.ips do |bench|
  bench.report("from time") { rng = Random::PCG32.new(Random.new_seed); rng.next_u }
  bench.report("from SecureRandom") do
    SecureRandom.random_bytes(bytes)
    rng = Random::PCG32.new(seed[0], seed[1])
    rng.next_u
  end
end
