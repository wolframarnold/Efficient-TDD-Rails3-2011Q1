require 'spec_helper'

describe User do

  it 'has a first_name' do
    User.new.should respond_to(:first_name)
  end

  it 'must have a first_name' do
    u = User.new
    u.should_not be_valid
    u.errors[:first_name].should_not be_empty
  end

  it 'must has a last name' do
    u = User.new
    u.should_not be_valid
    u.errors[:last_name].should_not be_empty
  end

end
