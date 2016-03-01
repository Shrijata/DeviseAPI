  class Api::SessionsController < Devise::SessionsController
  
  include ApiHelper
  
  prepend_before_filter :require_no_authentication, :only => [:create]
  skip_before_filter :verify_signed_out_user
  before_action :authenticate_user!, :except => :create

  include Devise::Controllers::Helpers

  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return failure unless resource
    if resource.valid_password?(params[:user][:password])
    render :json=> {:success => true, :token => resource.authentication_token,:email => resource.email}
    return
    end
    failure
  end

  def new
  super
  end

  def update
    super
  end

  def edit
  super
  end

  def destroy
    current_user.reset_token!
    user=current_user
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {success:true, user:user.email}, status: 200
  end


  def failure
    return render :json => { :success => false}
  end
  end
