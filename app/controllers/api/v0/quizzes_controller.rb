class API::V0::QuizzesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  
  # Save quiz (needs signed in user - for now system user. May consider user generated quiz later) 
  # @action POST
  # @url /api/v0/quizzes/create
  # @required user [Hash] user hash with user email and auth token
  # @required quiz [Hash] quiz hash with  :quiz_category, :question, :choice1, :choice2, :choice3, :choice4
  # @response [Json] quiz object
  def create
    return if invalid_action_for_anonymous_user?(@current_user)
    # add new quiz
    quiz = Quiz.new(params_create)
    if quiz.save
      render :json => {success:  true, quiz:  quiz.as_json}, status:  :created
    else
      warden.custom_failure!
      render :json => {success:  false, message:  quiz.errors.as_json}, status:  :unprocessable_entity
    end
  end

  # Get quiz for given id
  # @action POST
  # @url /api/v0/quizzes/show
  # @required user [Hash] quiz hash with user email and auth token
  # @required params [Hash] params hash with :id
  # @response [Json] quiz  object
  def show
    return if invalid_action_for_anonymous_user?(@current_user)
    quiz = Quiz.where(id: params_show[:id])
    render :json => {success:  true, quiz: quiz.as_json}, status:  :ok #200
  end

  # Update quiz for given id
  # @action POST
  # @url /api/v0/quizzes/update
  # @required user [Hash] user hash with user email and auth token
  # @optional quiz [Hash] quiz hash with  id: :quiz_category, :question, :choice1, :choice2, :choice3, :choice4
  # @response [Json] quiz  object
  def update
    return if invalid_action_for_anonymous_user?(@current_user)
    # update quiz
    quiz = Quiz.where(id: params_show[:id])
    # if there is so such quiz, then render error and return 
    if !quiz
      render :json => {success:  false, message:"Invalid Quiz Id"}, status:  :unprocessable_entity and return 
    end
          
    if quiz.update(params_update)
      render :json => {success:  true, quiz: quiz.as_json}, status:  :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message:  (quiz.errors.as_json)}, status:  :unprocessable_entity
    end
  end

  # Delete quiz given id 
  # @action POST
  # @url /api/v0/quizzes/update
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with :id
  # @response [Json] quiz  deletion sucess or failure message
  def delete
    return if invalid_action_for_anonymous_user?(@current_user)
    # delete quiz
    quiz = Quiz.where(id: params_show[:id])
    # if there is so such quiz, then render error and return 
    if !quiz
      render :json => {success:  false, message:"Invalid Quiz Id"}, status:  :unprocessable_entity and return 
    end
          
    if quiz.destroy
      render :json=> {:success=>true, :message=> "Quiz deleted"}, :status => :ok #200
    else
      warden.custom_failure!
      render :json => {success:  false, message: quiz.errors.as_json}, status:  :unprocessable_entity
    end
  end

  # Get list of quizzes for given category
  # @action POST
  # @url /api/v0/quizzes/get_list
  # @required user [Hash] user hash with user email and auth token
  # @required params [Hash] params hash with :quiz_category,:count,:offset
  # @response [Json] quizzes list
  def get_list
    return if invalid_action_for_anonymous_user?(@current_user)
    # get quizzes from quiz_manager
    quizzes = quiz_manager.get_quizzes(params_get_list)
    if(quizzes)
      render :json => {success: true, quizzes: quizzes.as_json}, status: :ok
    else
      render :json => {success: false, quiz: "Missing or Invalid parameter(s)"}, status: :unprocessable_entity
    end
  end

  # Get info of quiz category and count 
  # @action POST
  # @url /api/v0/quizzes/get_info
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] quiz category and count list
  def get_info
    # get quiz info from quiz_manager
    qinfo = quiz_manager.get_info
    if(qinfo)
      render :json => {success: true, quiz_info: qinfo.as_json}, status: :ok
    else
      render :json => {success: false, quiz: "Missing or Invalid parameter(s)"}, status: :unprocessable_entity
    end
  end
  
  # Get all quiz categories
  # @action POST
  # @url /api/v0/user_quizzes/get_categories
  # @required user [Hash] user hash with user email and auth token
  # @response [Json] preference question and options
  def get_categories
    render :json=> { success: true, category_list: category_list.as_json}, status: :ok 
  end
  
  private
  def params_show
    params.require(:params).permit(:id)
  end

  def params_create
    params.require(:quiz).permit(:quiz_category, :question, :choice1, :choice2, :choice3, :choice4)
  end

  def params_update
    params.require(:quiz).permit(:id, :quiz_category, :question, :choice1, :choice2, :choice3, :choice4)
  end

  def params_get_list
    params_ = params.require(:params).permit(:quiz_category,:count,:offset)
    convert_params_to_int(params_,[:quiz_category,:count,:offset])
    params_
  end
  
  def category_list
    pref = Quiz.new
    pref.question="Quiz Categories"
    pref.add_option(value=0, key="Random")
    pref.add_option(value=1, key="Basics")
    pref.add_option(value=2, key="Hobbies And Habits")
    pref.add_option(value=3, key="Personality")
    pref.add_option(value=4, key="Relationship")
    pref.add_option(value=5, key="Pop Culture")
    pref.add_option(value=6, key="Likes And Dislikes")
    pref.add_option(value=7, key="What Would You Do?")
    pref.add_option(value=8, key="Current Events")
    pref.add_option(value=9, key="How Smart Are you?")
    pref.add_option(value=10, key="Believes And Values")
    pref.quiz
  end

end
