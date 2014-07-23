require 'spec_helper'

describe Saltine::Salt do
  let(:input_values)  { [2] }
  let(:output_values) { [2 * salt] }

  ## These values excercise no additional lines of code
# let(:input_values)  { [nil, 1, 2] }
# let(:output_values) { [nil, salt * 1, salt * 2] }

  ## These values excercise three additional lines of code
# let(:input_values)  { [ :hello, nil,        1, "2", 3.0, [       4,        5], {a: 6       }] }
# let(:output_values) { [ :hello, nil, salt * 1, "2", 3.0, [salt * 4, salt * 5], {a: salt * 6}] }

  ## Isn't this tempting? Then I could assert cracker.salt.should eql(salt) ... why not?
# let(:salt)          { 2 }
# let(:output_values) { [:hello, nil, 2, "2", 3.0, [8,10], {a: 12}] }

  let(:cracker)   { Saltine::Salt.new(*input_values) }
  let(:salt)      { cracker.salt }

  ## This is precisely the first & possibly the only test I would write
  it "salts nested fixnum values" do
    cracker.salted.should == output_values
  end

  context "when 'aggressive' is set" do
    let(:cracker)       { Saltine::Salt.new(aggressive: true, unsalted: input_values) }
    let(:output_values) { [ :hello, 0, salt, salt * 2, salt * 3, [salt * 4, salt * 5], {a: salt * 6}] }

    ## This test provides only one additional line of coverage
    it "salts any values that can be cast to a fixnum" do
      pending "this test is fairly redundant"
      cracker.salted.should eql(output_values)
    end
  end
end
