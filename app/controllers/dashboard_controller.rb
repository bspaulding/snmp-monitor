# = DashboardController
#
# Author: Bradley J. Spaulding
#
# === Purpose
# This is the home/root controller, handling input from the main interface. 
# All routes under /dashboard.
class DashboardController < ApplicationController
	before_filter :authenticate
	
  # GET /dashboard
  def index
  	@agent = Agent.new
  end

	# AJAX /dashboard/show_down
	def show_down
		render :update do |page|
			page.replace_html 'agents_table', :partial => 'agents_table', :object => Agent.down
		end
	end
	
	# AJAX /dashboard/show_favorites
	def show_favorites
		render :update do |page|
			page.replace_html 'agents_table', :partial => 'agents_table', :object => Agent.favorites
		end
	end
	
	# AJAX /dashboard/show_all
	def show_all
		render :update do |page|
			page.replace_html 'agents_table', :partial => 'agents_table', :object => Agent.all
		end
	end
end
