class API::V0::UserBlacklistsController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  
  # Create user blacklist for signed in user
  # @action POST
  # @url /api/v0/user_blacklists/create
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with  :userid_blacklisted,:blacklist_reason_id
  # @response [Json] user blacklist object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new blacklist
    blacklist = UserBlacklist.new(params_create)
    blacklist.user_id = @current_user.id
    if blacklist.save
      render :json => {success:  true, blacklist:  blacklist.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, blacklist:  (blacklist.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  private

 def reasons_list
    reasons = Quiz.new
    reasons.question="BlackList User Because"
    reasons.add_option(value=0, key="Unknown")
    reasons.add_option(value=1, key="NotApproved")
    reasons.add_option(value=2, key="Rejected")
    reasons.add_option(value=3, key="Blocked")
    reasons.add_option(value=4, key="Flagged")
    reasons.quiz
  end
  
  def params_create
    params.require(:params).permit(:userid_blacklisted,:blacklist_reason_id)
  end
  
end
