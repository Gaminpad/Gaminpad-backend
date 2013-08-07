module GaminpadAuth

  def self.included(base)
    base.class_eval do
      
      #helpers
      helpers do
        def current_player
          current_player ||= Player.token_authorize(headers['Authorization-Token'])
        end
        
        def authenticate_player!
          current_player = Player.authenticate_with_email(params[:email], params[:password])
          if current_player
            return current_player
          else
            error!('Unauthorized Request: Wrong email/password', 401)
          end
        end
        
        def verify_token
          error!('Unauthorized Request: Token invalid', 401) unless current_player
        end
      end

      resource :tokens do
        
        desc 'Create new token through email/password authentication'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post '/' do
          current_player = authenticate_player!
          if current_player
            {
              authorized: 'ok',
              token: current_player.authentication_token
            }
          end
        end
        
        desc 'Check token validity.'
        get '/' do
          verify_token
          {
            authorized: 'ok',
            player: current_player
          }
        end
      end

    end
  end

end