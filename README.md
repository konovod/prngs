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
         Random::MT19937   22.1M ( 45.26ns) (± 5.47%)  3.97× slower
           Random::ISAAC  34.79M ( 28.75ns) (± 4.96%)  2.52× slower
Random::Xorshift1024star  68.51M (  14.6ns) (± 6.27%)  1.28× slower
Random::Xoroshiro128plus  87.65M ( 11.41ns) (± 4.12%)       fastest
           Random::PCG32  64.48M ( 15.51ns) (± 7.04%)  1.36× slower
         Random::WELL512  22.56M ( 44.32ns) (± 1.91%)  3.88× slower
        Random::ChaCha20  22.07M ( 45.32ns) (± 4.90%)  3.97× slower
            SecureRandom    2.0M (500.61ns) (± 1.11%) 43.88× slower
```
