require 'spec_helper'

describe User do

  context "is not valid" do
    #  subject { User.new }  -- not strictly necessary so long we have describe User up top

    [:first_name, :last_name].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid  # when followed by should or should_not, subject. is optional
        subject.errors[attr].should_not be_empty
      end
    end

    it 'without correctly formatted email' do
      subject.email = 'abcd'
      subject.should_not be_valid
      subject.errors[:email].should_not be_empty
      subject.errors[:email].should == ['is not a valid email address']
    end
  end

  it 'does not report :admin in json respresentation' do
    u = Factory(:user)
    u.as_json['user'].should_not include('admin')
  end

  context "full_name" do

    it 'is a callable method' do
      should respond_to(:full_name)  # subject. is implied here, since it's followed by should
    end

    it 'returns first_name + last_name as middle name' do
      u = User.new(:first_name => "Joe", :last_name => "Smith")
      u.full_name.should == 'Joe Smith'
    end

    it 'includes middle name when present' do
      u = User.new(:first_name => "Joe", :middle_name => "M", :last_name => "Smith")
      u.full_name.should == "Joe M Smith"
    end

  end

  context "attr_accessible" do
    it 'should not permit mass assignment of admin?' do
      u = User.new(:admin => true)
      u.should_not be_admin
    end
  end

  context "shipping address" do
    it 'has many shipping addresses' do
      subject.should respond_to(:shipping_addresses)
    end

    it 'can create a shipping address' do
      subject.attributes = {:first_name => "Joe", :last_name => "Smith"}
      subject.save!
      expect {
        subject.shipping_addresses.create(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321")
      }.to change(ShippingAddress,:count).by(1)
    end

    context "nested attributes" do
      subject { Factory(:user) }

      it 'can be updated via nested attributes' do
        lambda {
          subject.attributes = {:shipping_addresses_attributes => [Factory.attributes_for(:shipping_address)]}
          subject.save!
          puts subject.errors
        }.should change {subject.shipping_addresses.count}.by(1)
      end

      it "won't add a shipping address if all fields are blank" do
        lambda {
          subject.attributes = {:shipping_addresses_attributes => [:street => '', :city => '', :state => '', :zip =>'']}
          subject.save!
        }.should_not change {subject.shipping_addresses.count}
      end

      it 'can delete an address via nested attributes and _destroy flag' do
        addr = subject.shipping_addresses.create(Factory.attributes_for(:shipping_address))
        lambda {
          subject.attributes = {:shipping_addresses_attributes => [{:id => addr.id, :_destroy => 1}]}
          subject.save!
        }.should change{subject.shipping_addresses.count}.by(-1)  # addresses(true) causes a reload
      end

    end

  end

end
