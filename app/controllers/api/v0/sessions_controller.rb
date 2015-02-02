class API::V0::SessionsController < Devise::SessionsController
  #before_filter :authenticate_api_v0_user!#, :except => [:create]
  #skip_before_filter :verify_authenticity_token
  skip_before_filter :verify_signed_out_user
  # helpers
  include ApplicationHelper::APIHelper

  before_filter :ensure_params_exist
  respond_to :json
  #force_ssl
  
  
  # Create user session and issue an auth token
  # @action POST
  # @url /api/v0/signin
  # @required user [Hash] user hash with  :email,:password
  # @response [Json] user object
  def create
    user = User.find_for_database_authentication(email:  params[:user][:email])
    return invalid_login_attempt("invalid_email") unless user
    # anonymous user cannot sign in
    return if invalid_action_for_anonymous_user?(user)

    if user.valid_password?(params[:user][:password])
      user.ensure_authentication_token!
      render :json=> {:success=>true, user: user.as_json}, :status => :ok #200

    return
    end
    invalid_login_attempt("invalid_password")
  end

  # Close user session and reset auth token
  # @action POST
  # @url /api/v0/signout
  # @required user [Hash] user hash with  :email,:password
  # @response [Json] message with success or failure 
  def destroy
    user = User.find_for_database_authentication(email:  params[:user][:email],:authentication_token => params[:user][:authentication_token])
    if user && user.authentication_token
      # anonymous user cannot sign out
      return if invalid_action_for_anonymous_user?(user)
      user.reset_authentication_token!
      render :json=> {:success=>true, :message=> "Authetication token deleted"}, :status => :ok #200
    else
      render :json=> {:success=>false, :message=> "Unauthorized user"}, :status =>   :bad_request # 400
    end
  end

  private

  def ensure_params_exist
    return unless params[:user].blank? || params[:user][:email].blank?
    render :json=>{:success=>false, :message=>"Missing login email parameter"}, :status => :unprocessable_entity #422
  end

  def invalid_login_attempt(option=nil)
    warden.custom_failure!
    login_err_msg = "Error with your login or password"
    login_err_msg = "Invalid email"  if option == "invalid_email"
    login_err_msg = "Invalid password" if option == "invalid_password"

    render :json=> {:success=>false, :message=>login_err_msg}, status:  :unauthorized # 401
  end

end
