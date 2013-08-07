class Player < ActiveRecord::Base

  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :games, :join_table => :game_joins
  has_many :games_owned, :source => :games

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :encrypted_password, :authentication_token,
                  :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at,
                  :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at,
                  :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at
  # attr_accessible :title, :body
  
  validates :username, :uniqueness => true, :format => {:with => /\A[A-Za-z0-9_]{3,50}\z/, :on => :create, :message => 'Only A-Z, 0-9 and _ allowed'}, :length => { :minimum => 3, :maximum => 30 }
  validates :email, :uniqueness => true, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create}
  
  #before_create :ensure_authentication_token
  
  def self.token_authorize(token)
    self.find_by_authentication_token(token)
  end
  
  def self.authenticate_with_email(email, password)
    user = self.find_by_email(email.downcase)
    if user && user.valid_password?(password)
      return user
    else
      nil
    end
  end
  
  def self.authenticate_with_username(username, password)
    user = self.find_by_username(username)
    if user && user.valid_password?(password)
      return user
    else
      nil
    end
  end
  
  
end
