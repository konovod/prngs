require "spec"
require "../src/prngs/chacha20"

def test_vector(key, nonce, stream)
  m = Random::ChaCha20.new(key.map(&.to_u32), nonce)
  stream.each do |n|
    m.next_u.should eq(n.to_u32)
  end
end

describe "Random::ChaCha20" do
  it "generates random numbers that match test vectors for reference implementation" do
    test_vector(
      [0x00000000, 0x00000000, 0x00000000, 0x00000000,
       0x00000000, 0x00000000, 0x00000000, 0x00000000],
      0x0000000000000000_u64,
      [0xade0b876, 0x903df1a0, 0xe56a5d40, 0x28bd8653,
       0xb819d2bd, 0x1aed8da0, 0xccef36a8, 0xc70d778b,
       0x7c5941da, 0x8d485751, 0x3fe02477, 0x374ad8b8,
       0xf4b8436a, 0x1ca11815, 0x69b687c3, 0x8665eeb2]
    )
    test_vector(
      [0x00000000, 0x00000000, 0x00000000, 0x00000000,
       0x00000000, 0x00000000, 0x00000000, 0x01000000],
      0x0000000000000000_u64,
      [0x5af04045, 0x96b21f9f, 0x7b6e73d7, 0x963c8e20,
       0x83e14feb, 0x60d28846, 0x5209454f, 0x412d43ed,
       0xb6a0e2bb, 0xd26675ea, 0xe2e7d1a5, 0x2caf420d,
       0xb192d753, 0x81ea3fc4, 0x75d29a7e, 0x636954ae]
    )
    # test_vector(
    #   [0x00000000, 0x00000000, 0x00000000, 0x00000000,
    #    0x00000000, 0x00000000, 0x00000000, 0x00000000],
    #   0x00_00_00_00_00_00_00_01_u64,
    #   [0x7bba9cde, 0xf59ed6f3, 0x63dc86e7, 0x3a653f97,
    #    0x15e0490b, 0x13f7bfad, 0xf17dcb4f, 0x31108237,
    #    0x02055ae8, 0x4508a778, 0x734f2127, 0x5bfac7ef,
    #    0x2e067752, 0x3e43a0b7, 0xe3415f44]
    # )
  end

  it "can jump ahead (inside block)" do
    seed = 12345_u64
    m1 = Random::ChaCha20.new(seed)
    m2 = Random::ChaCha20.new(seed)
    6.times { m1.next_u }
    m2.jump(6)
    m1.next_u.should eq m2.next_u
  end
  it "can jump ahead (between blocks)" do
    seed = 12345_u64
    m1 = Random::ChaCha20.new(seed)
    m2 = Random::ChaCha20.new(seed)
    100.times { m1.next_u }
    m2.jump(100)
    m1.next_u.should eq m2.next_u
  end
  it "can jump back" do
    seed = 12345_u64
    m1 = Random::ChaCha20.new(seed)
    m2 = Random::ChaCha20.new(seed)
    1000.times { m1.next_u }
    m1.jump(-5)
    m1.jump(-13)
    m1.jump(-(1000 - 5 - 13))
    m1.next_u.should eq m2.next_u
  end
end
