# prngs

Crystal implementations of PCG32, XorShift1024* and Xoroshiro128+, WELL512, ChaCha12, ChaCha20, ISAAC+ pseudorandom generators.

See http://www.pcg-random.org for more details about PCG

See http://xoroshiro.di.unimi.it for more details about xorshift family

# Usage
   This shard provides additional implementations of `Random` module, so usage is identical to usage of `Random` in stdlib.
   Also, PCG32 and ChaCha12/20 implements `jump` method that allows to instantly travel along generated sequence forward and backward. See examples in `spec`
# Speed
Benchmark results on my laptop:
```
[andrew@lenovo prngs]$ crystal -v
Crystal 0.23.1 (2017-07-17) LLVM 4.0.1
[andrew@lenovo prngs]$ crystal bench.cr
Warning: benchmarking without the `--release` flag won't yield useful results
         Random::MT19937   2.08M (479.94ns) (± 1.07%)  2.83× slower
           Random::ISAAC   1.88M (532.21ns) (± 2.59%)  3.14× slower
       Random::ISAACPlus   1.84M (543.98ns) (± 1.85%)  3.20× slower
Random::Xorshift1024star   5.89M (169.76ns) (± 2.22%)       fastest
Random::Xoroshiro128plus   5.69M ( 175.7ns) (± 2.41%)  1.03× slower
      Random::ShardPCG32   5.04M (198.51ns) (± 2.43%)  1.17× slower
         Random::WELL512   2.15M (464.87ns) (± 2.58%)  2.74× slower
      Random::ChaCha(20) 137.62k (  7.27µs) (± 1.15%) 42.80× slower
      Random::ChaCha(12) 225.96k (  4.43µs) (± 0.64%) 26.07× slower
            SecureRandom   1.77M (566.23ns) (± 1.27%)  3.34× slower
65554439.77777062
[andrew@lenovo prngs]$ crystal bench.cr --release
         Random::MT19937  21.99M ( 45.47ns) (± 4.23%)  4.12× slower
           Random::ISAAC  35.42M ( 28.24ns) (± 6.12%)  2.56× slower
       Random::ISAACPlus  34.13M (  29.3ns) (± 6.96%)  2.65× slower
Random::Xorshift1024star  70.57M ( 14.17ns) (± 6.36%)  1.28× slower
Random::Xoroshiro128plus  90.55M ( 11.04ns) (± 4.40%)       fastest
      Random::ShardPCG32  64.03M ( 15.62ns) (± 6.25%)  1.41× slower
         Random::WELL512  22.76M ( 43.94ns) (± 2.04%)  3.98× slower
      Random::ChaCha(20)   22.1M ( 45.24ns) (± 4.17%)  4.10× slower
      Random::ChaCha(12)  28.69M ( 34.85ns) (± 4.22%)  3.16× slower
            SecureRandom   2.01M (497.42ns) (± 1.41%) 45.04× slower
973336292.1701912
```
