class AppsController < ApplicationController

	before_filter :valid_app_slug

	def index
		render :file => 'public/landing-app', :layout => false
	end
	
	def api_index
	  render :file => 'public/landing-api', :layout => false
	end

end
