# prngs

Crystal implementations of PCG32, XorShift1024* and Xoroshiro128+, WELL512, ChaCha20 pseudorandom generators.

See http://www.pcg-random.org for more details about PCG
See http://xoroshiro.di.unimi.it for more details about xorshift family

# Usage
   This shard provides additional implementations of `Random` module, so usage is identical to usage of `Random` in stdlib.
   Also, PCG32 and ChaCha20 implements `jump` method that allows to instantly travel along generated sequence forward and backward. See examples in `spec`
# Speed
Benchmark results on my laptop:
```
[andrew@lenovo prngs]$ crystal -v
Crystal 0.22.0 (2017-04-22) LLVM 4.0.0
[andrew@lenovo prngs]$ crystal run bench.cr --release
Random::MT19937  22.13M ( 45.18ns) (± 4.42%)  4.06× slower
  Random::ISAAC  34.61M (  28.9ns) (± 5.80%)  2.60× slower
Random::Xorshift1024star  68.56M ( 14.59ns) (± 6.62%)  1.31× slower
Random::Xoroshiro128plus  89.96M ( 11.12ns) (± 5.66%)       fastest
  Random::PCG32  65.73M ( 15.21ns) (± 6.88%)  1.37× slower
Random::WELL512  22.51M ( 44.42ns) (± 2.15%)  4.00× slower
Random::ChaCha20  22.04M ( 45.38ns) (± 4.84%)  4.08× slower
   SecureRandom    2.0M (500.46ns) (± 1.12%) 45.02× slower
```
