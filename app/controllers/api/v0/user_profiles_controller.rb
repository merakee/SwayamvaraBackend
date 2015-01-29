class API::V0::UserProfilesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new profile
    profile = UserProfile.new(params_create)
    profile.user_id = @current_user.id
    if profile.save
      render :json => {:success => true,:profile => profile.as_json}, :status=> :created
    else
      warden.custom_failure!
      render :json => {:success => false, :message => (profile.errors.as_json)}, :status=> :unprocessable_entity
    end
  end

  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    render :json => @current_user.profile.as_json(root: true), :status=> :ok #200
  end

  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    profile = @current_user.user_profile
    if profile.update(params_update)
      render :json => {:success => true, :profile => profile.as_json}, :status=> :ok #200
    else
      warden.custom_failure!
      render :json => {:success => false, :message => (profile.errors.as_json)}, :status=> :unprocessable_entity
    end
  end

  def delete
    return if invalid_action_for_anonymous_user?(@current_user)
    # update current user
    profile = @current_user.user_profile
    if profile.destroy 
      render :json=> {:success=>true, :message=> "User Profile deleted"}, :status => :ok #200
    else
      warden.custom_failure!
      render :json => {:success => false, :message => (profile.errors.as_json)}, :status=> :unprocessable_entity
    end
  end

  private
  def params_create
    params.require(:profile).permit(:user_name,:brith_year,:sex,:sex_preferred,:height,:weight)
  end

  def params_update
    params.require(:profile).permit(:user_name,:height,:weight)
  end

end