  module ApiHelper

  def validate_auth_token
    self.resource = User.find_by_authentication_token(params[:auth_token])
  end

  def current_user
    @current_user ||= User.find_by_authentication_token(request.headers['access-token'])
  end
  
end

  











