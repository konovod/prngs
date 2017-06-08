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
         Random::MT19937  22.31M ( 44.83ns) (± 4.18%)  3.76× slower
           Random::ISAAC  33.05M ( 30.26ns) (± 5.11%)  2.54× slower
Random::Xorshift1024star  64.84M ( 15.42ns) (± 5.84%)  1.29× slower
Random::Xoroshiro128plus  83.87M ( 11.92ns) (± 4.84%)       fastest
           Random::PCG32   70.6M ( 14.16ns) (± 7.43%)  1.19× slower
         Random::WELL512  31.87M ( 31.38ns) (± 4.79%)  2.63× slower
```
