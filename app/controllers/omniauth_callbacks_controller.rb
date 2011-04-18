class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # p request.env['omniauth.auth'].inspect

    @user = User.with_twitter_uid(request.env['omniauth.auth']['uid']).first
#                                            :username => request.env['omniauth.auth']['nickname'],
#                                            :avatar => request.env['omniauth.auth']['user_info']['image'])
    flash[:notice] = "Signed in successfully via Twitter"
    if @user.nil?
      session['devise.twitter_uid']=request.env['omniauth.auth']['uid']
      session['devise.twitter_user_info']=request.env['omniauth.auth']['user_info']
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, :event => :authentication
    end
  end
  
end
