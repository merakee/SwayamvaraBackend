require 'rails_helper'

describe "Routes for" do

  describe "Root Paths: " do
    specify "root" do
      expect(:get =>  "/").to route_to(
      :controller => "api/v0/sessions",
      :action => "create")
    end

    specify "api root" do
      expect(:get =>  "api/v0").to route_to(
      :controller => "api/v0/sessions",
      :action => "create",
      :format =>:json)
    end
  end

  describe "Registration Paths: " do
    specify "sign up" do
      expect(:post =>  "api/v0/signup").to route_to(
      :controller => "api/v0/registrations",
      :action => "create",
      :format =>:json)
    end

    it "sign up via get" do
      expect(:get =>  "api/v0/signup").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/signup")
    end

  end

  describe "Session Paths: " do
    specify "sign in" do
      expect(:post =>  "api/v0/signin").to route_to(
      :controller => "api/v0/sessions",
      :action => "create",
      :format =>:json)
    end
    specify "sign in via get" do
      expect(:get =>  "api/v0/signin").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/signin")
    end

    specify "sign out" do
      expect(:delete =>  "api/v0/signout").to route_to(
      :controller => "api/v0/sessions",
      :action => "destroy",
      :format =>:json)
    end
    specify "sign out via get" do
      expect(:get =>  "api/v0/signout").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/signout")
    end
    specify "sign out via post" do
      expect(:post =>  "api/v0/signout").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/signout")
    end

  end

  describe "User Paths: " do
    it "create" do
      expect(:post =>  "api/v0/users/create").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/users/create")
    end

    it "show" do
      expect(:post =>  "api/v0/users/show").to route_to(
       :controller => "api/v0/users",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/users/update").to route_to(
       :controller => "api/v0/users",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/users/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/users/delete")
    end

  end

  describe "User Profile Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_profiles/create").to route_to(
       :controller => "api/v0/user_profiles",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_profiles/show").to route_to(
       :controller => "api/v0/user_profiles",
       :action => "show",
       :format =>:json)
    end

    it "get profile" do
      expect(:post =>  "api/v0/user_profiles/get_profile").to route_to(
       :controller => "api/v0/user_profiles",
       :action => "get_profile",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/user_profiles/update").to route_to(
       :controller => "api/v0/user_profiles",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/user_profiles/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_profiles/delete")
    end

  end

  describe "User Preference Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_preferences/create").to route_to(
       :controller => "api/v0/user_preferences",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_preferences/show").to route_to(
       :controller => "api/v0/user_preferences",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/user_preferences/update").to route_to(
       :controller => "api/v0/user_preferences",
       :action => "update",
       :format =>:json)
    end

    it "get list" do
      expect(:post =>  "api/v0/user_preferences/get_list").to route_to(
       :controller => "api/v0/user_preferences",
       :action => "get_list",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/user_preferences/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_preferences/delete")
    end

  end

  describe "User Picture Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_pictures/create").to route_to(
       :controller => "api/v0/user_pictures",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_pictures/show").to route_to(
       :controller => "api/v0/user_pictures",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/user_pictures/update").to route_to(
       :controller => "api/v0/user_pictures",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/user_pictures/delete").to route_to(
       :controller => "api/v0/user_pictures",
       :action => "delete",
       :format =>:json)
    end

  end

  describe "User Rating Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_ratings/create").to route_to(
       :controller => "api/v0/user_ratings",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_ratings/show").to route_to(
       :controller => "api/v0/user_ratings",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/user_ratings/update").to route_to(
       :controller => "api/v0/user_ratings",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/user_ratings/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_ratings/delete")
    end

  end

  describe "User Match Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_matches/create").to route_to(
       :controller => "api/v0/user_matches",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_matches/show").to route_to(
       :controller => "api/v0/user_matches",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/user_matches/update").to route_to(
       :controller => "api/v0/user_matches",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/user_matches/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_matches/delete")
    end

  end

  describe "User Message Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_messages/create").to route_to(
       :controller => "api/v0/user_messages",
       :action => "create",
       :format =>:json)
    end

    it "get list" do
      expect(:post =>  "api/v0/user_messages/get_list").to route_to(
       :controller => "api/v0/user_messages",
       :action => "get_list",
       :format =>:json)
    end

    it "get user list" do
      expect(:post =>  "api/v0/user_messages/get_user_list").to route_to(
       :controller => "api/v0/user_messages",
       :action => "get_user_list",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_messages/show").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_messages/show")
    end

    it "update" do
      expect(:post =>  "api/v0/user_messages/update").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_messages/update")
    end

    it "delete" do
      expect(:post =>  "api/v0/user_messages/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_messages/delete")
    end

  end

  describe "Flagged User Paths: " do
    it "create" do
      expect(:post =>  "api/v0/flagged_users/create").to route_to(
       :controller => "api/v0/flagged_users",
       :action => "create",
       :format =>:json)
    end

    it "get list" do
      expect(:post =>  "api/v0/flagged_users/get_list").to route_to(
       :controller => "api/v0/flagged_users",
       :action => "get_list",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/flagged_users/show").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/flagged_users/show")
    end

    it "update" do
      expect(:post =>  "api/v0/flagged_users/update").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/flagged_users/update")
    end

    it "delete" do
      expect(:post =>  "api/v0/flagged_users/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/flagged_users/delete")
    end

  end

  describe "User Blacklist Paths: " do
    it "create" do
      expect(:post =>  "api/v0/user_blacklists/create").to route_to(
       :controller => "api/v0/user_blacklists",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/user_blacklists/show").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_blacklists/show")
    end

    it "update" do
      expect(:post =>  "api/v0/user_blacklists/update").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_blacklists/update")
    end

    it "delete" do
      expect(:post =>  "api/v0/user_blacklists/delete").to route_to(
       :controller => "application",
       :action => "routing_error",
       :format =>:json,
       :all => "api/v0/user_blacklists/delete")
    end

  end

  describe "Quiz Paths: " do
    it "create" do
      expect(:post =>  "api/v0/quizzes/create").to route_to(
       :controller => "api/v0/quizzes",
       :action => "create",
       :format =>:json)
    end

    it "show" do
      expect(:post =>  "api/v0/quizzes/show").to route_to(
       :controller => "api/v0/quizzes",
       :action => "show",
       :format =>:json)
    end

    it "update" do
      expect(:post =>  "api/v0/quizzes/update").to route_to(
       :controller => "api/v0/quizzes",
       :action => "update",
       :format =>:json)
    end

    it "delete" do
      expect(:post =>  "api/v0/quizzes/delete").to route_to(
       :controller => "api/v0/quizzes",
       :action => "delete",
       :format =>:json)
    end

    it "get info" do
      expect(:post =>  "api/v0/quizzes/get_info").to route_to(
       :controller => "api/v0/quizzes",
       :action => "get_info",
       :format =>:json)
    end

    it "get list" do
      expect(:post =>  "api/v0/quizzes/get_list").to route_to(
       :controller => "api/v0/quizzes",
       :action => "get_list",
       :format =>:json)
    end

    it "get categories" do
      expect(:post =>  "api/v0/quizzes/get_categories").to route_to(
       :controller => "api/v0/quizzes",
       :action => "get_categories",
       :format =>:json)
    end
    
  end

  describe "Random Paths: " do
    it "via get" do
      expect(:get => "some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "some/random/path/to/nowhere")
    end
    it "via get through api" do
      expect(:get => "api/v0/some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/some/random/path/to/nowhere")
    end
    it "via put" do
      expect(:put => "some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "some/random/path/to/nowhere")
    end
    it "via put through api" do
      expect(:put => "api/v0/some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/some/random/path/to/nowhere")
    end

    it "via delete" do
      expect(:delete => "some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "some/random/path/to/nowhere")
    end
    it "via delete through api" do
      expect(:delete => "api/v0/some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/some/random/path/to/nowhere")
    end

    it "via update" do
      expect(:update => "some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "some/random/path/to/nowhere")
    end
    it "via update through api" do
      expect(:update => "api/v0/some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/some/random/path/to/nowhere")
    end

    it "via patch" do
      expect(:patch => "some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "some/random/path/to/nowhere")
    end
    it "via patch through api" do
      expect(:patch => "api/v0/some/random/path/to/nowhere").to route_to(
      :controller => "application",
      :action => "routing_error",
      :format =>:json,
      :all => "api/v0/some/random/path/to/nowhere")
    end
  end
end
