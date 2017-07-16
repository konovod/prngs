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
Crystal 0.23.0 (2017-07-13) LLVM 4.0.1
[andrew@lenovo prngs]$ crystal bench.cr
Warning: benchmarking without the `--release` flag won't yield useful results
         Random::MT19937   2.08M (479.71ns) (± 3.60%)  2.88× slower
           Random::ISAAC   1.84M (543.39ns) (± 2.84%)  3.26× slower
Random::Xorshift1024star    6.0M (166.73ns) (± 2.34%)       fastest
Random::Xoroshiro128plus   5.65M (176.99ns) (± 2.92%)  1.06× slower
           Random::PCG32   5.27M (189.58ns) (± 2.54%)  1.14× slower
         Random::WELL512   2.17M (460.33ns) (± 0.99%)  2.76× slower
        Random::ChaCha20  138.3k (  7.23µs) (± 0.41%) 43.37× slower
        Random::ChaCha12 224.08k (  4.46µs) (± 0.36%) 26.76× slower
            SecureRandom   1.73M (579.42ns) (± 1.20%)  3.48× slower
61292302.781848624
[andrew@lenovo prngs]$ crystal bench.cr --release
         Random::MT19937  22.22M (  45.0ns) (± 4.35%)  4.06× slower
           Random::ISAAC  34.76M ( 28.77ns) (± 4.69%)  2.60× slower
Random::Xorshift1024star  70.07M ( 14.27ns) (± 7.06%)  1.29× slower
Random::Xoroshiro128plus  90.27M ( 11.08ns) (± 4.66%)       fastest
           Random::PCG32  68.55M ( 14.59ns) (± 7.08%)  1.32× slower
         Random::WELL512  22.55M ( 44.34ns) (± 2.00%)  4.00× slower
        Random::ChaCha20  22.19M ( 45.07ns) (± 4.31%)  4.07× slower
        Random::ChaCha12  29.24M (  34.2ns) (± 4.72%)  3.09× slower
            SecureRandom   2.01M (498.15ns) (± 1.42%) 44.97× slower
```
