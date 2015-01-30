class API::V0::UserProfilesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!

  # Create user profile for signed in user
  # @action POST
  # @url /api/v0/user_profiles/create
  # @required user [Hash] user hash with user email and auth token
  # @required profile [Hash] profile hash with  :user_name,:brith_year,:sex,:sex_preferred,:height,:weight
  # @response [Json] user profile object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new profile
    profile = UserProfile.new(params_create)
    profile.user_id = @current_user.id
    if profile.save
      render :json => {success:  true,:profile => profile.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (profile.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Get user profile for signed in user
  # @action POST
  # @url /api/v0/user_profiles/show
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] user profile object
  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    render :json => {success:  true,:profile => @current_user.profile.as_json(root: true)}, status:  :ok #200
  end

  # Get user profile for given user_id
  # @action POST
  # @url /api/v0/user_profiles/get_profile
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with user_id
  # @response [Json] user profile object
  def get_profile
    profile  = UserProfile.where(user_id: params_get_profile)
    if profile 
      render :json => {success:  true, :profile => profile.as_json}, status:  :ok
    else
      render :json => {success:  false, message:  "Invalid user id"}, status:  :unprocessable_entity
    end
  end

  # Update user profile for signed in user
  # @action POST
  # @url /api/v0/user_profiles/update
  # @required user [Hash] user hash with user email and auth token
  # @optional profile [Hash] profile hash with  :user_name,:height,:weight
  # @response [Json] user profile object
  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    profile = @current_user.user_profile
    if profile.update(params_update)
      render :json => {success:  true, :profile => profile.as_json}, status:  :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (profile.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Delete user profile for signed in user
  # @action POST
  # @url /api/v0/user_profiles/delete
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] delete action success or failure message
  def delete
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    profile = @current_user.user_profile
    if profile.destroy
      render :json=> {:success=>true, message: "User Profile deleted"}, :status => :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (profile.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  private

  def params_get_profile
    params.require(:params).permit(:user_id)
  end

  def params_create
    params.require(:profile).permit(:user_name,:brith_year,:sex,:sex_preferred,:height,:weight)
  end

  def params_update
    params.require(:profile).permit(:user_name,:height,:weight)
  end

end