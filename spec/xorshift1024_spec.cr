require "spec"
require "../src/prngs/xorshift"

describe "Random::Xorshift1024star" do
  it "generates random numbers as generated official implementation" do
    numbers = [7318853836271591753_u64,
               9274623446119407168_u64,
               7680446314077579600_u64,
               17082585102123344681_u64,
               17137567043538026650_u64,
               7937722105151092774_u64,
               11116912673301324510_u64,
               11068800607127969389_u64,
               6297635292564734785_u64,
               13519641119573099720_u64,
               12130373279879659717_u64,
               14360720272095099140_u64,
               6871195285874576390_u64,
               3810992938594941976_u64,
               702052121116926886_u64,
               9924167817777718969_u64,
               11779260473802976832_u64,
               6704443352799728691_u64,
               8135383811252218836_u64,
               8895372961824568755_u64,
               10286073723938788972_u64,
               7092470943059603460_u64,
               7965246990187368385_u64,
               7210101736085100830_u64,
               12609608380247765674_u64,
               16734156809779408751_u64,
               17685015894048411994_u64,
               12967080891160409700_u64,
               8206358809489724725_u64,
               15710959248597008897_u64,
               7891602991951624915_u64,
               13522388770433915878_u64,
               13885329677457736606_u64,
               5437216125826981154_u64,
               5828187362897965181_u64,
               1826814258047946771_u64,
               101076847761330219_u64,
               13722996303463886065_u64,
               8903413737919218637_u64,
               10036164134225207667_u64,
               10110544340826414078_u64,
               11616405843100478553_u64,
               11290966342014554162_u64,
               3279405133651105250_u64,
               18129332858809600283_u64,
               3842465837554359418_u64,
               6716889316224152410_u64,
               13315990744358110323_u64,
               8582117804084448577_u64,
               7011339168466747000_u64]
    seed = 1477780182365762752_u64

    m = Random::Xorshift1024star.new(seed)
    numbers.each do |n|
      m.next_u.should eq(n)
    end
  end
end
