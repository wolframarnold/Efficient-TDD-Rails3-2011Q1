require 'spec_helper'

describe "Using mocks" do

  # Note: These specs don't test any application code
  # They merely are here to illustrate how mocks, stub methods and partial mocks work.

  it 'with inline stub methods' do
    m = mock("A Mock", :foo => 'hello')
    m.should respond_to(:foo)

    m.foo.should == "hello"
  end

  it 'with explicit method stub' do
    m = mock("A mock")
    m.stub(:foo).and_return("hello")

    m.should respond_to(:foo)
    m.foo("arg").should == "hello"
  end

  it 'with expected method invocation count' do
    m = mock("A mock")
    m.should_receive(:foo)

    m.foo
  end

  it 'with argument matching' do
    m = mock("A mock")
    m.should_receive(:foo).with(hash_including(:name => "joe"))

    m.foo({:name => 'joe', :address => '123 Main'})
  end

  it 'with block argument matcher' do
    m = mock("A mock")
    m.should_receive(:foo).with{ |arg1, arg2|
      arg1 == 'hello' && arg2.blank?
    }

    m.foo('hello','')
  end

  it 'stubbing methods on existing classes' do
    jan1 = DateTime.civil(2010).to_time

    Time.stub!(:now).and_return(jan1)

    Time.now.should == jan1
  end

  it 'with mock_model' do
    mm = mock_model(User)
    mm.should respond_to(:id)
    puts mm.id
    mm.should respond_to(:new_record?)
    puts mm.new_record?
  end

end