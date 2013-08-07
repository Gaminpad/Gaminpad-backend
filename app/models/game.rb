class Game < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_and_belongs_to_many :players, :join_table => :game_joins
  
end
