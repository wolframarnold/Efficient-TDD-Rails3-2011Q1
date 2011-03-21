require 'spec_helper'

describe Order do

  it 'requires a shipping address' do
    should_not be_valid
    subject.errors[:shipping_address].should_not be_empty
  end

  it 'can be created by factory' do
    expect {
      Factory(:order)
    }.to change(Order,:count).by(1)
  end
end
