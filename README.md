# prngs

Crystal implementations of PCG32, XorShift1024* and Xoroshiro128+, faster and better algorithms then Mersenne Twister used by default

See http://www.pcg-random.org for more details about PCG
See http://xoroshiro.di.unimi.it for more details about xorshift family

# Usage
   This shard provides additional implementations of `Random` module, so usage is identical to usage of `Random` in stdlib.
# Speed
Benchmark results on my laptop:
```
[andrew@lenovo prngs]$ crystal -v
Crystal 0.22.0 (2017-04-22) LLVM 4.0.0
[andrew@lenovo prngs]$ crystal run bench.cr --release
         Random::MT19937  28.05M ( 35.65ns) (± 2.21%)  7.63× slower
           Random::ISAAC  39.69M ( 25.19ns) (± 2.72%)  5.39× slower
Random::XorShift1024Star  94.46M ( 10.59ns) (± 3.99%)  2.26× slower
Random::Xoroshiro128plus  213.9M (  4.67ns) (± 4.99%)       fastest
           Random::PCG32 181.28M (  5.52ns) (± 4.66%)  1.18× slower
```
