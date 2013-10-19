module GaminpadGamesEntities
  
  class GameEntity < Grape::Entity
    expose :id
    expose :title
    expose :status
    expose :last_played
  end
  
end