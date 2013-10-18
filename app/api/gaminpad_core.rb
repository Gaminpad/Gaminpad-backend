GP_MODULES_PATH = File.expand_path("../../modules",  __FILE__)

module GaminpadCore
  
  class APICore < Grape::API
    
    version 'v1', using: :path
    format :json
    rescue_from :all, :backtrace => true
    
    # Loading general modules
    self.send(:include, GaminpadAuth)
    self.send(:include, GaminpadGames)
    
    helpers do
      
      def load_app_modules(app_slug)
        modfile_path = File.expand_path("../../apps/#{app_slug}/Modfile",  __FILE__)
        File.open(modfile_path).each do |line|
          if line.start_with?('mod')
            modname = line.match(/'(\S+)'/).captures.first
            puts "loading module (#{modname})"
            # Loading custom modules
            # require "#{GP_MODULES_PATH}/#{modname}/#{modname}"
            # self.class.send(:include, GaminpadAuth)
            # APICore.singleton_class.send(:include, GaminpadGames)
          else
            puts "Modfile line ignored"
          end
        end
      end
      
      
      def valid_app_slug
        @app_slug = request.host.split('.').first
        @app = App.find_by_url_slug(@app_slug)
        if @app.nil?
          error!("Invalid App Slug: #{@app_slug}", 400)
          false
        else
          true
        end
      end
    end
    
    before do
      if valid_app_slug
        load_app_modules(@app_slug)
      end
    end

    resource :ping do
      desc 'Test purpose. Sends a pong response.'
      get '/' do
        { pong: "true", :app => @app_slug }
      end
    end
    
  end
  
end