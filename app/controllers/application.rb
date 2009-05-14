# = ApplicationController
#
# Author: Bradley J. Spaulding
#
# === Purpose
# This application controller provides space for methods available to all 
# controllers for each request.

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8b398a33203a350fb701069f4ce4c88e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def authenticate
  	unless session[:logged_in]
  		session[:intended_controller] = controller_name
  		session[:intended_action] = action_name
  		redirect_to :controller => 'login'
  	end
  end
end
