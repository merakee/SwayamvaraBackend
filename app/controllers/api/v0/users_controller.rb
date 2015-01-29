class API::V0::UsersController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  
  # Get user information for signed in user 
  # @action POST 
  # @url /api/v0/users/show 
  # @required user [Hash] user hash with user email and auth token 
  # @response [Json] user object  

  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    render :json => @current_user.as_json(root: true), :status=> :ok #200
  end

  # update user information for signed in user 
  # @action POST 
  # @url /api/v0/users/update 
  # @required user [Hash] user hash with user email and auth token 
  # @required profile [Hash] profile hash with  :email,:password,:password_confirmation
  # @response [Json] user object
  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    if @current_user.update(params_update)
      render :json => {:success => true, :user => @current_user.as_json}, :status=> :ok #200
    else
      warden.custom_failure!
      render :json => {:success => false, :message => (@current_user.errors.as_json)}, :status=> :unprocessable_entity
    end
  end

  private

  def params_update
    params.require(:user).permit(:email,:password,:password_confirmation)
  end

end
