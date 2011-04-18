require 'spec_helper'

describe OmniauthCallbacksController do
  include Devise::TestHelpers

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context "Existing user" do

    before do
      @twitter_user = Factory(:twitter_user, :uid => '123456789abc')
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter].merge('uid' => '123456789abc')
      get :twitter
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end
    it 'should sign the user in' do
      controller.user_signed_in?.should be_true
    end

  end

  context "New user" do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter].merge('uid' => 'random_uid_string')
      get :twitter
    end

    it 'should redirect user to registration form' do
      response.should redirect_to(new_user_registration_path)
    end

    it 'should not sign the user in' do
      controller.user_signed_in?.should be_false
    end

    it 'stores the user_info hash in the session' do
      session['devise.twitter_uid'].should == 'random_uid_string'
      session['devise.twitter_user_info'].should == OmniAuth.config.mock_auth[:twitter]['user_info']
    end
  end

end
