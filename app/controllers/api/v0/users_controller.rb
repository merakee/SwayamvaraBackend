class API::V0::UsersController < API::V0::APIController
  before_filter  :authenticate_user_from_token!

  # Get user information for signed in user
  # @action POST
  # @url /api/v0/users/show
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] user object
  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    render :json => {success: true, user: @current_user.as_json}, status:  :ok #200
  end

  # Update user information for signed in user
  # @action POST
  # @url /api/v0/users/update
  # @required user [Hash] user hash with user email and auth token
  # @optional update_params [Hash] update_params hash with  :email,:password,:password_confirmation
  # @response [Json] user object
  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    if @current_user.update(params_update)
      render :json => {success:  true, user: @current_user.as_json}, status:  :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (@current_user.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  private

 # For user list and associated id see APIConstants::API_USER_TYPE
 # def user_type_list
    # type_list = Quiz.new
    # type_list.question="User Type"
    # type_list.add_option(value=1, key="Anonymous")
    # type_list.add_option(value=2, key="Email")
    # type_list.quiz
  # end
  
  def params_update
    params.require(:update_params).permit(:email,:password,:password_confirmation)
  end

end
