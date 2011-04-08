require 'spec_helper'

describe Product do

  before :all do
    FakeWeb.allow_net_connect = false
    rss_fixture = File.open(File.join(Rails.root,'spec','fixtures','amazon_rss_feed.xml')).read
    FakeWeb.register_uri(:get, Product::BASE_URL, :body => rss_fixture)
  end

  context "class methods" do

    it 'has a fetch_all method' do
      Product.should respond_to(:fetch_all)
    end
    it 'returns a collection of products' do
      Product.fetch_all.each do |p|
        p.should be_kind_of(Product)
      end
      Product.fetch_all.length.should == 5
    end
    it 'returns the first product with correct attributes' do
      prod = Product.fetch_all.first
      prod.title.should include("Garmin Forerunner")
      prod.link.should include("http://www.amazon.com/Garmin-Forerunner-Receiver-Heart-Monitor")
      prod.image_url.should == "http://ecx.images-amazon.com/images/I/51lHg9ZcN7L._SL160_SS160_.jpg"
    end


  end

  context "instance methods" do
    %w(title link image_url).each do |attr|
      it "responds to #{attr}" do
        Product.new.should respond_to(attr)
      end
    end

    [:title, :link, :image_url].each do |attr|
      it "should return the correct #{attr}" do
        prod = Product.new(attr => 'my attr')
        prod.send(attr).should == 'my attr'
      end
    end

  end
end
