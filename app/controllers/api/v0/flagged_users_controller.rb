class API::V0::FlaggedUsersController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  
  # Create flagged user for signed in user
  # @action POST
  # @url /api/v0/flagged_users/create
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with  :userid_flagged,:flagging_reason_id
  # @response [Json] flagged object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new flagged
    flagged = FlaggedUser.new(params_create)
    flagged.user_id = @current_user.id
    if flagged.save
      render :json => {success:  true, flagged:  flagged.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, flagged:flagged.errors.as_json}, status:  :unprocessable_entity
    end
  end

  # Get list of reasons for flagging 
  # @action POST
  # @url /api/v0/flagged_users/get_list
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] flagging_reason_list object with flagging question and options
  def get_list
    render :json=> { success: true, flagging_reason_list: reasons_list.as_json}, status: :ok 
  end
  
  private

 def reasons_list   
    reasons = Quiz.new
    reasons.question="Flagging this user because"
    #reasons.add_option(value=0, key="Unknown")
    reasons.add_option(value=1, key="Offensive")
    reasons.add_option(value=2, key="Fake Profile")
    reasons.add_option(value=3, key="Cannot see face")
    reasons.add_option(value=4, key="Spam")
    reasons.quiz
  end
  
  def params_create
    params.require(:params).permit(:userid_flagged,:flagging_reason_id)
  end
end
