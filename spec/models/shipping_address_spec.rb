require 'spec_helper'

describe ShippingAddress do
  it 'belongs to user' do
    should respond_to(:user)
  end

  context "is not valid" do
    [:street, :city, :zip, :state, :user].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end

    it "limits country to 2 letter when present" do
      subject.country = "USA"
      subject.should_not be_valid
      subject.errors[:country].should_not be_empty
    end
  end

  context "optional country" do
    subject do
      u = User.create(:first_name => 'Joe', :last_name => 'Smith')
      u.shipping_addresses.build(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321")
    end

    it 'is set to "US" if left blank' do
      subject.country.should be_blank
      subject.save!
      subject.country.should == 'US'
    end

    it 'is not overridden with "US" if set' do
      subject.country = "CA"
      subject.save!
      subject.country.should == 'CA'
    end

  end

  context "scopes" do
    before do
      @us_ca = Factory(:shipping_address, :state => 'CA')
      @us_nv = Factory(:shipping_address, :state => 'NV')
      @mx = Factory(:shipping_address, :country => "MX")
    end

    it 'finds all US addresses' do
      ShippingAddress.us.all.should == [@us_ca, @us_nv]
    end

    it 'finds all addresses in a given state' do
      ShippingAddress.in_state('NV').all.should == [@us_nv]
    end

  end

  context "orders" do
    before do
      @user  = Factory(:user)
      @addr1 = Factory(:shipping_address, :user => @user)
      @addr2 = Factory(:shipping_address, :city => 'LA', :zip => '34567', :user => @user)
      @addr3 = Factory(:shipping_address, :city => 'NY', :zip => '56789', :user => @user)
    end

    it 'shows all shipping addresses previously used, in order of most use by order' do
      @order1 = Factory(:order, :shipping_address => @addr1, :created_at => 5.months.ago)
      @order2 = Factory(:order, :shipping_address => @addr2, :created_at => 10.months.ago)
      @order3 = Factory(:order, :shipping_address => @addr3, :created_at => Time.now)

      @user.shipping_addresses.on_file.all.should == [@addr3, @addr1, @addr2]
    end

    it 'does not show shipping addresses of orders older than 1 year' do
      @order1 = Factory(:order, :shipping_address => @addr1)
      @order2 = Factory(:order, :shipping_address => @addr2, :created_at => 13.months.ago)

      @user.shipping_addresses.on_file.all.should == [@addr1]
    end

    it 'does not show duplicate addresses' do
      @order1 = Factory(:order, :shipping_address => @addr1)
      @order2 = Factory(:order, :shipping_address => @addr1)

      @user.shipping_addresses.on_file.all.should == [@addr1]
    end
  end

end
