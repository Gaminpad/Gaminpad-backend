module GaminpadAuthEntities
  
  class PlayerEntity < Grape::Entity
    expose :username
    expose :email
    expose :created_at
  end
  
end