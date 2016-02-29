class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_token, if: :new_record?

  def reset_token!
  	set_token
  	save
  end

  private

  	def set_token
  		self.authentication_token = Devise.friendly_token
  	end

end
