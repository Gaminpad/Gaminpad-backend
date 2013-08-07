class AppsController < ApplicationController

	before_filter :valid_app_slug

	def show
		render :file => 'public/landing-app', :layout => false
	end

end
