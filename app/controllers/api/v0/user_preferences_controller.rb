class API::V0::UserPreferencesController < API::V0::APIController
 before_filter  :authenticate_user_from_token!

  # Create user preference for signed in user
  # @action POST
  # @url /api/v0/user_preferences/create
  # @required user [Hash] user hash with user email and auth token
  # @required preference [Hash] preference hash with  :user_name,:brith_year,:sex,:sex_preferred,:height,:weight
  # @response [Json] user preference object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new preference
    preference = UserPreference.new(params_create)
    preference.user_id = @current_user.id
    if preference.save
      render :json => {success:  true, preference: preference.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (preference.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Get user preference for signed in user
  # @action POST
  # @url /api/v0/user_preferences/show
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] user preference object
  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    render :json => {success:  true, preference: @current_user.preference.as_json}, status:  :ok #200
  end
  
  # Get user preference for given user_id
  # @action POST
  # @url /api/v0/user_preferences/get_preference
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with user_id
  # @response [Json] user preference object
  def get_preference
    preference  = UserPreference.where(user_id: params_get_preference)
    if preference
      render :json => {success:  true, preference:  preference.as_json}, status:  :ok
    else
      render :json => {success:  false, message:  "Invalid user id"}, status:  :unprocessable_entity
    end
  end

  # Update user preference for signed in user
  # @action POST
  # @url /api/v0/user_preferences/update
  # @required user [Hash] user hash with user email and auth token
  # @optional preference [Hash] preference hash with  :user_name,:height,:weight
  # @response [Json] user preference object
  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    preference = @current_user.user_preference
    if preference.update(params_update)
      render :json => {success:  true, preference: preference.as_json}, status:  :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (preference.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Delete user preference for signed in user
  # @action POST
  # @url /api/v0/user_preferences/delete
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] delete action success or failure message
  def delete
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    preference = @current_user.user_preference
    if preference.destroy
      render :json=> {success: true, message: "User preference deleted"}, status: :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (preference.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Get all preference question and options 
  # @action POST
  # @url /api/v0/user_preferences/get_list
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] preference question and options
  def get_list
    render :json=> { success: true, preference_list: preference_list.as_json}, status: :ok 
  end
  
  private

  def params_get_preference
    params.require(:params).permit(:user_id)
  end

  def params_create
    params.require(:preference).permit(:user_name,:brith_year,:sex,:sex_preferred,:height,:weight)
  end

  def params_update
    params.require(:preference).permit(:user_name,:height,:weight)
  end

  def preference_list
    {distance:distance_preference_list,age:age_preference_list,relationship: relationship_preference_list}
  end
 def distance_preference_list
    pref = Quiz.new
    pref.question="What's your comfort zone?"
    pref.add_option(value=0, key="Anywhere")
    pref.add_option(value=10, key="Within 10Km")
    pref.add_option(value=100, key="Within 100Km")
    pref.add_option(value=500, key="Within 500Km")
    pref.add_option(value=-10, key="Outside 10Km")
    pref.add_option(value=-100, key="Outside 100Km")
    pref.add_option(value=-500, key="outside 500Km")
    pref.quiz
  end

  def relationship_preference_list
    pref = Quiz.new
    pref.question="What you looking for?"
    pref.add_option(value=1, key="Just online chat")
    pref.add_option(value=2, key="Frinds to hang out")
    pref.add_option(value=3, key="Relationship")
    pref.quiz
  end

  def age_preference_list
    pref = Quiz.new
    pref.question="What age group are you interested in?"
    pref.add_option(value=1, key="Around my age")
    pref.add_option(value=2, key="Older than me")
    pref.add_option(value=3, key="Younger than me")
    pref.add_option(value=4, key="Any")
    pref.quiz
  end
  
end
