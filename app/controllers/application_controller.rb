class ApplicationController < ActionController::Base

  def authenticate_user!
  	user_token = request.headers['access-token']
  	if user_token.present?
  		invalid_token unless User.find_by_authentication_token(user_token)
  	else
  		invalid_token
  	end
  end

  def invalid_token
  	render json: 'Invalid token', status: 401
  end
end
