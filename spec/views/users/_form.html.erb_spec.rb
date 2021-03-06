require 'spec_helper'

describe 'users/_form.html.erb' do
  before do
    user = Factory.build(:user)
    user.shipping_addresses.build
    assign(:user, user)
    render
  end

  it 'should have first_name and last_name fields' do
    rendered.should have_selector('form') do |f|
      f.should have_selector("input[name='user[first_name]']")
      f.should have_selector('input[name="user[last_name]"]')
    end
  end

  it 'has a form posting to /users' do
    rendered.should have_selector("form[action='/users']")
  end

end