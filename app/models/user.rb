  class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 

  before_save :set_token, if: :new_record?

  def reset_token!
  	set_token
  	save
  end

  def valid_token?(token)
    self.authentication_token == token
  end

  private

  	def set_token
      begin
        self.authentication_token = Devise.friendly_token
      end while self.class.exists?(authentication_token: authentication_token)
  	end

  end
