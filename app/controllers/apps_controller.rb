class AppsController < ApplicationController

	before_filter :valid_app_slug
	

	def show
		render :file => 'public/landing-app', :layout => false
	end

	def api
		render :text => "API method undefined for Slug: #{@slug}"
	end

end
