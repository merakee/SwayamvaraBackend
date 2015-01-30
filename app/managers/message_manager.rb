class MessageManager
  
  def get_messages(params)
    # check params
    return nil unless is_params_valid(params)
    set_default_params(params)
    UserMessage.where(user_id: params[:user_id]).where(userid_sent_to: params[:userid_sent_to]).order(created_at: :desc).limit(params[:count]).offset(params[:offset])
  end
  
  def get_user_list(params)
    # check params
    return nil unless is_params_valid_for_user_list(params)
    UserMessage.where(user_id: params[:user_id]).order(created_at: :desc).pluck(:userid_sent_to).uniq
  end
  
  def set_default_params(params)
    params[:count] = APIConstants::MESSAGE::ITEM_COUNT_PER_REQUEST unless params.has_key?(:count) && params[:count] && params[:count]>0
    params[:offset] = 0 unless params.has_key?(:offset) && params[:offset] && params[:offset] >= 0
  end
  
  def is_params_valid_for_user_list(params)
    params.has_key?(:user_id) && params[:user_id] 
  end 
  
  def is_params_valid(params)
    params.has_key?(:user_id) && params[:user_id] && params.has_key?(:userid_sent_to) && params[:userid_sent_to]
  end 
end