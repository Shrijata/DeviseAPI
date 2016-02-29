class Api::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  skip_before_filter :verify_authenticity_token 
  before_filter :ensure_params_exist
 
  respond_to :json
  
  def create
    resource = User.find_for_database_authentication(:email=>params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json=> {:success=>true, :auth_token=>resource.authentication_token,:email=>resource.email}
      return
    end
    invalid_login_attempt
  end
  
  def destroy
    current_user.reset_token!
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render json: true
  end

  protected
  
  def ensure_params_exist
    return unless params[:user].blank?
    render :json=>{:success=>false, :message=>"missing user parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

  def verify_signed_out_user
    
  end
end








