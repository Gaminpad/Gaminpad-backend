include GaminpadGamesEntities

module GaminpadGames

  def self.included(base)
    base.class_eval do
      
      helpers GaminpadGamesHelpers
    
      resource :games do
        desc 'List players games'
        get '/' do
          verify_token
          @games = current_player.games
          present @games, with: GaminpadGamesEntities::GameEntity
        end
        
        desc 'Create a game'
        params do
          optional :title, type: String, regexp: /^[0-9a-zA-Z\s_-]{3,}$/, desc: "Game Title"
        end
        post '/' do
          verify_token
          @game = Game.new(:player => current_player, :title => params[:title])
          @game.players << current_player
          if @game.save
            present @game, with: GaminpadGamesEntities::GameEntity
          else
            error!("Error creating game: #{@game.errors.as_json}", 400)
          end
        end
        
        desc "Delete a Game"
        params do
          requires :id, type: String, desc: "Status ID."
        end
        delete ':id' do
          verify_token
          @game = current_player.games_owned.find_by_id(params[:id])
          if @game && @game.destroy
            { :game => @game.id, :status => :deleted }
          else
            error!("Error deleting game with Id(#{params[:id]})", 400)
          end
        end
        
      end

    end
  end

end