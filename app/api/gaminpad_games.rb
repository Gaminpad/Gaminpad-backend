GP_MODULE_PATH = File.expand_path('..', __FILE__)

# require "#{GP_MODULE_PATH}/gaminpad_games_entities"
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
      end

    end
  end

end