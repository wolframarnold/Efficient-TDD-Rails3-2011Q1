module IntegrationSpecHelper
  def login_with_via(service = :twitter)
    # Note: We're using the ActionDispatch::IntegrationTest API here
    # This is Rails's own native Integration framework (with a thin RSPec wrapper around it).
    # It is not Capybara or Webrat!
    # see: http://railsapi.com/doc/rails-v3.0.4/classes/ActionDispatch/IntegrationTest.html
    get "/users/auth/#{service}"
    follow_redirect!
  end
end
