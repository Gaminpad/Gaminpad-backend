class ApplicationController < ActionController::Base
  protect_from_forgery

  APP_SLUG_NOT_VALID = 'App not found. Check URL, please'

  def index
  	render :file => 'public/landing-gaminpad'
  end

  protected

  def valid_app_slug
  	@slug = request.subdomain
  	@app = App.find_by_url_slug(@slug)
  	if @app
  		return
  	else
  		#raise ApplicationController::APP_SLUG_NOT_VALID
  		render :text => "<h1>App not valid</h1> Slug: <strong>#{@slug}</strong>", :status => 404
  	end
  end


end
