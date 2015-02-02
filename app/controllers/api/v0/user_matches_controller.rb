class API::V0::UserMatchesController < API::V0::APIController
  before_filter  :authenticate_user_from_token!
  def create
  end

  def show
  end

  def update
  end

  def delete
  end
  
  private 
   def match_status_list
    status_list = Quiz.new
    status_list.question="Match Status List"
    status_list.add_option(value=0, key="Unknown")
    status_list.add_option(value=1, key="Expressed")
    status_list.add_option(value=2, key="Accepted")
    status_list.add_option(value=3, key="Rejected")
    status_list.add_option(value=4, key="Serious")
    status_list.quiz
  end
end
