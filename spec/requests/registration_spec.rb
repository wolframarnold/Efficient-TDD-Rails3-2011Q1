require 'spec_helper'

describe "Sign in via Twitter for New User" do
  before :all do
    FakeWeb.allow_net_connect = true
    OmniAuth.config.test_mode = false
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean!
  end

  context "from home page" do
    before do
      visit '/'
    end

    it 'goes to Twitter' do
      click_link 'Sign in with Twitter'
      page.current_url.should =~ %r{api.twitter.com/oauth/authenticate}
    end

    context "on Twitter page" do
      before do
        click_link 'Sign in with Twitter'
      end

      it 'accepts Twitter credentials and redirects to sign-up page' do
        fill_in 'Username or Email:', :with => TWITTER_USERNAME
        # Note: Twitter's API sign-in page had a bug, where the label for Password carries the wrong ID
        # Hence we need to locate the password field by name
        fill_in 'session[password]', :with => TWITTER_PASSWORD
        click_button 'Sign in'
        page.current_path.should == '/users/sign_up'
      end

      context "on Sign-up page" do
        before do
          # Note: We'd ordinarily be already logged in from the previous attempt.
          # To force fresh login with username and password on Twitter every time, the :force_login OmniAuth config option is available
          fill_in 'Username or Email:', :with => TWITTER_USERNAME
          fill_in 'session[password]', :with => TWITTER_PASSWORD
          click_button 'Sign in'
        end

        it 'accepts email, first, last name and proceeds to home page' do
          fill_in 'Email', :with => Factory.attributes_for(:user)[:email]
          fill_in 'First name', :with => 'Sally'
          fill_in 'Last name', :with => 'Parker'
          click_button 'Create account'
          page.current_path.should == '/'
          page.should have_content('Welcome! You have signed up successfully.')
          page.should have_link('Sign out')
        end
      end
    end
  end
end
