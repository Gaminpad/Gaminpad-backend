class AppsController < ApplicationController

	before_filter :valid_app_slug
	

	def show
		#render :text => "App found! Status: #{@app.status.to_s}"
		render :file => 'public/landing-app' 
	end

	def api
		render :text => "API method undefined for Slug: #{@slug}"
	end

end
