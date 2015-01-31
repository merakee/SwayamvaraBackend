class QuizManager
  
  def get_quizzes(params)
    # check params
    return nil unless is_params_valid(params)
    set_default_params(params)
    Quiz.where(quiz_category: params[:quiz_category]).order(id: :asc).limit(params[:count]).offset(params[:offset])
  end
  
  def get_info
    Quiz.group(:quiz_category).count
  end
  
  def set_default_params(params)
    params[:count] = APIConstants::QUIZE::ITEM_COUNT_PER_REQUEST unless params.has_key?(:count) && params[:count] && params[:count]>0
    params[:offset] = 0 unless params.has_key?(:offset) && params[:offset] && params[:offset] >= 0
  end
   
  def is_params_valid(params)
    params.has_key?(:quiz_category) && params[:quiz_category] && params[:quiz_category] >=0 && params[:quiz_category] <=10
  end 
end