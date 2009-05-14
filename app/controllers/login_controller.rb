# = LoginController
#
# Author: Bradley J. Spaulding
#
# === Purpose
# This controller handles all routes under /login,
# and provides session handling logic.
class LoginController < ApplicationController
  def index
  end

	def login
		session[:logged_in] = User.authenticate(params[:email], params[:password])
		if session[:logged_in]
			if(session[:intended_controller] == "login")
				session[:intended_controller] = "dashboard"
				session[:intended_action] = "index"
			end
			redirect_to url_for(:controller => session[:intended_controller], :action => session[:intended_action])
		else
			flash[:error] = "Invalid Email/Password Combination. Please Try Again."
			redirect_to :action => 'index'
		end
	end
	
	def logout
		session[:logged_in] = nil
		redirect_to :controller => 'dashboard'
	end
end
