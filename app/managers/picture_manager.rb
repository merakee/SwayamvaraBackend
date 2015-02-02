class MessageManager
  
  def get_pictures(params)
    # check params
    return nil unless is_params_valid(params)
    set_default_params(params)
    UserPicture.where(user_id: params[:user_id]).order(display_order: :asc)
  end
  
  def is_params_valid(params)
    params.has_key?(:user_id) && params[:user_id]
  end 
end