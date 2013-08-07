module GaminpadGames

  def self.included(base)
    base.class_eval do
    
      #helpers
      helpers do
      end

      resource :games do
        desc 'Check token validity.'
        get '/' do
          authenticate!
          {
            authorized: 'ok',
            user: nil
          }
        end
      end

    end
  end

end