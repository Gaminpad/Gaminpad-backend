module GaminpadCore
  
  class APICore < Grape::API
    
    version 'v1', using: :path
    format :json
    rescue_from :all #, :backtrace => true
    
    include GaminpadAuth
    include GaminpadGames
    
    helpers do
      def valid_app_slug
        puts "DEBUG :: request -> #{request.inspect}"
        @slug = request.host.split('.').first
        @app = App.find_by_url_slug(@slug)
        error!("Invalid App Slug: #{@slug}", 400) if @app.nil?
      end
    end
    
    before do
      valid_app_slug
    end

    resource :ping do
      desc 'Test purposes. Sends a pong response.'
      get '/' do
        { pong: "true", :app => @slug }
      end
    end
    
  end
  
end