class API::V0::UserPicturesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  
  
  # Get user picture for a given picture id 
  # @action POST
  # @url /api/v0/user_pictures/show
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with picture_id
  # @response [Json] user picture object
  def show 
    # show single picture 
    picture = UserPicture.where(id:params_show[:picture_id])[0]
    if picture   
      #render :json => {success:  true, pictrue:  picture.as_json(only: select_keys_for_picture)}, status:  :ok
      render :json => {success:  true, pictrue:  picture.as_json}, status:  :ok
    else
      render :json => {success:  false, message:  "Invalid picture id"}, status:  :unprocessable_entity
    end
  end

  # Get all pictures for a given user id 
  # @action POST
  # @url /api/v0/user_pictures/get_list
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with user_id
  # @response [Json] user picture object
  def get_list 
    # show single picture 
    pictures = picture_manager.get_pictures(params_get_list)
    if picture   
      render :json => {success:  true, pictrues:  pictures.as_json}, status:  :ok
    else
      render :json => {success:  false, message:  "Invalid picture id"}, status:  :unprocessable_entity
    end
  end
    
  # Save user picture for signed in user
  # @action POST
  # @url /api/v0/user_pictures/create
  # @required user [Hash] user hash with user email and auth token
  # @required picture [Hash] picture hash with  :photo_token,:is_private,:display_order
  # @response [Json] user picture object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
        
    # add a new picture
    picture = UserPicture.new(params_create)
    picture.user_id = @current_user.id
    if picture.save
      #render :json => {success:  true,pictrue:  (picture.as_json(only: select_keys_for_picture))}, status:  :created
      render :json => {success:  true,pictrue:  picture.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, message:  picture.errors.as_json}, status:  :unprocessable_entity
    end

    ensure
     clean_tempfile
  end
  
  # Delete user picture for given picture id for the owner
  # @action POST
  # @url /api/v0/user_pictures/delete
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with picture_id
  # @response [Json] user picture object
  def delete
    return if invalid_action_for_anonymous_user?(@current_user)
        
    # check if admin 
    #render :json => {success:  false, message: "Unauthorized user"}, status: :unauthorized and return unless is_admin
        
    # delete picture
    picture = picture.where(id: params_delete[:picture_id])[0]
    
    # check user is authorized 
    render :json => {success: false, message: "Unauthorized user"}, status: :unauthorized and return unless is_autorized(picture.user_id)
    
    if picture.destroy
      render :json => {success: true, message: "User Picture deleted"}, status:  :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  picture.errors.as_json}, status:  :unprocessable_entity
    end
  end
  
  
 private

  def params_create
    process_photo_token_params(params[:picture][:photo_token]) unless params[:picture].nil?
    params.require(:picture).permit(:photo_token,:is_private,:display_order)
  end

  def params_show
    params.require(:params).permit(:picture_id)
  end

  def params_get_list
    params.require(:params).permit(:user_id)
  end
  
  def params_delete
    params.require(:params).permit(:picture_id)
  end

  def is_admin
    admin_pass = params.require(:params).permit(:admin_pass)[:admin_pass]
    (!admin_pass.blank?) && admin_pass.eql?(ENV['ADMIN_PASS'])
  end
  
  def is_authorized(user_id)
  is_admin || (user_id.eql?@current_user.id)
  end 

  def process_photo_token_params(photo_token)
    if photo_token && photo_token[:file]
      @tempfile = Tempfile.new('picture_photo')
      @tempfile.binmode
      @tempfile.write Base64.decode64(photo_token[:file])
      @tempfile.rewind

      params[:picture][:photo_token] = ActionDispatch::Http::UploadedFile.new(
      tempfile: @tempfile,
      picture_type: photo_token[:picture_type],
      filename: photo_token[:filename])
    end
  end

  def clean_tempfile
    # clean up tempfile user for params processing
    # close! closes and deletes (unlicks) the file
    @tempfile.close!  if @tempfile
  end
  
end
