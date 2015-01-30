class API::V0::UserMessagesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  # Save user message for signed in user
  # @action POST
  # @url /api/v0/user_messages/create
  # @required user [Hash] user hash with user email and auth token
  # @required message [Hash] message hash with  :userid_sent_to,:message
  # @response [Json] message object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new message
    message = UserMessage.new(params_create)
    message.user_id = @current_user.id
    if message.save
      render :json => {success:  true, message:  message.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (message.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Get list of messages with given user_id for current user
  # @action POST
  # @url /api/v0/user_messages/get_list
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with :userid_sent_to,:count,:offset
  # @response [Json] messages list
  def get_list
    # get contents for user: History  manager
    messages = message_manager.get_messages(params_get_list.merge({user_id:@current_user.id}))
    if(contents)
      render :json => {success: true, messages: messages.as_json}, status: :ok
    else
      render :json => {success: false, message: "Missing or Invalid parameter(s)"}, status: :unprocessable_entity
    end
  end

  # Get list of users that current user is have exhanged message with
  # @action POST
  # @url /api/v0/user_messages/get_user_list
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] message object
  def get_user_list
    # get contents for user: History  manager
    users = message_manager.get_user_list({params:{user_id:@current_user.id}})
    if(contents)
      render :json => {success: true, users: users.as_json}, status: :ok
    else
      render :json => {success: false, message: "Missing or Invalid parameter(s)"}, status: :unprocessable_entity
    end
  end

  private

  def params_create
    params.require(:message).permit(:userid_sent_to,:message)
  end

  def params_get_list
    params_ = params.require(:params).permit(:userid_sent_to,:count,:offset)
    convert_params_to_int(params_,[:userid_sent_to,:count,:offset])
    params_
  end

end
