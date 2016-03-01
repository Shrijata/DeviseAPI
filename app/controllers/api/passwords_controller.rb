class Api::PasswordsController < Devise::PasswordsController
  
  respond_to :json
  before_action :authenticate_user!,:except => :create
  
  def create
    @user = User.send_reset_password_instructions(params[:user])
    if successfully_sent?(@user)
      render :status => 200, :json => {:success => true}
    else
      render :status => 422, :json => { :errors => @user.errors.full_messages }
    end
  end

  def update
    super
  end

end
