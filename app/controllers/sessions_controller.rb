class SessionsController < ApplicationController

#  def create
#    session[:name] = request.env['omniauth.auth']['user_info']['name']
#    session[:uid] = request.env['omniauth.auth']['uid']
#    session[:provider] = request.env['omniauth.auth']['provider']
#    session[:provider] = request.env['omniauth.auth']['provider']
#    session[:avatar] = request.env['omniauth.auth']['user_info']['image']
#    session[:nickname] = request.env['omniauth.auth']['user_info']['nickname']
#    redirect_to root_path
#  end

  def destroy
    sign_out(:user)
    redirect_to root_path
  end

end
