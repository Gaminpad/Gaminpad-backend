module GaminpadBase
  
  class API < Grape::API
    
    version 'v1', using: :path
    format :json
    
    helpers do
      def current_user
        @current_user ||= User.token_authorize(headers['Authorization-Token'])
      end

      def authenticate!
        error!('Unauthorized Request', 401) unless current_user
      end
      
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
        { pong: "true", :slug => @slug }
      end
    end
    
    resource :tokens do
      desc 'Check token validity.'
      get '/' do
        authenticate!
        {
          authorized: 'ok',
          user: current_user
        }
      end
    end
    
  end
end