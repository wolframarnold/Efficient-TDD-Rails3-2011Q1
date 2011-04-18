require 'spec_helper'

describe 'layouts/application' do
  include Devise::TestHelpers

  before do
    controller.controller_path = "users"
    controller.request.path_parameters['controller'] = "application"  # Note: request hash is NOT Indifferent Access!!!
    controller.request.path_parameters['action'] = "index"

    @user = Factory(:twitter_user)
  end

  context "when logged in" do

    before do
      sign_in @user
      render
    end

    it 'should show log out link' do
      rendered.should have_selector("a[href='#{destroy_user_session_path}']", :content => "Sign out")
    end
  end

  context "when not logged in" do
    before do
      sign_out @user
      render
    end

    it 'should show log in link' do
      rendered.should have_selector("a[href='/users/auth/twitter']", :content => "Sign in with Twitter")
    end

  end
end
