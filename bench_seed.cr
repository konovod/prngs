require "secure_random"
require "benchmark"
require "./src/prngs/pcg"

seed = Slice(UInt64).new(2)
bytes = seed.to_unsafe.as(UInt8*).to_slice(2*sizeof(UInt64))

# Benchmark.ips do |bench|
#   bench.report("time") { Random.new_seed }
#   bench.report("SecureRandom") { SecureRandom.random_bytes(bytes) }
# end
#
x = 0
# Benchmark.ips do |bench|
#   bench.report("from time") { rng = Random::PCG32.new(Random.new_seed); 1000.times { x += rng.next_u } }
#   bench.report("from SecureRandom") do
#     SecureRandom.random_bytes(bytes)
#     rng = Random::PCG32.new(seed[0], seed[1])
#     1000.times { x += rng.next_u }
#   end
# end
p 650.0/15
