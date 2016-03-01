class Api::RegistrationsController < Devise::RegistrationsController
  
  include ApiHelper
  
  skip_before_filter :verify_signed_out_user
  before_action :authenticate_user! ,:except => :create
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email)
      return
    else
      render :json=> user.errors
    end
  end

  
  def new
    super
  end


  
  def edit
    super
  end

  
  def update
    super
  end

  
  def destroy
    super
  end

  
  def account_update_params
     devise_parameter_sanitizer.sanitize(:account_update)
  end


  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

end