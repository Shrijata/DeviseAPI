class Api::RegistrationsController < Devise::RegistrationsController
  
  skip_before_filter :verify_authenticity_token 
  respond_to :json
  
  def create
    @user = User.new(user_params)
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      render :json=> user.errors, :status=>422
    end
  end


   def destroy
    if @user
      @user.destroy
      yield @user if block_given?

      render json: {
        status: 'success',
        message: "Account has been destroyed."
      }
    else
      render json: {
        status: 'error',
        errors: ["Unable to locate account for destruction."]
      }, status: 404
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end



