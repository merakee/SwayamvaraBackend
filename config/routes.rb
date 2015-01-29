Rails.application.routes.draw do
  get 'quizzes/create'

  get 'quizzes/show'

  get 'quizzes/update'

  get 'quizzes/delete'

  get 'user_blacklists/create'

  get 'user_blacklists/show'

  get 'user_blacklists/update'

  get 'user_blacklists/delete'

  get 'flagged_users/create'

  get 'flagged_users/show'

  get 'flagged_users/update'

  get 'flagged_users/delete'

  get 'user_messages/create'

  get 'user_messages/show'

  get 'user_messages/update'

  get 'user_messages/delete'

  get 'user_matches/create'

  get 'user_matches/show'

  get 'user_matches/update'

  get 'user_matches/delete'

  get 'user_ratings/create'

  get 'user_ratings/show'

  get 'user_ratings/update'

  get 'user_ratings/delete'

  get 'user_pictures/create'

  get 'user_pictures/show'

  get 'user_pictures/update'

  get 'user_pictures/delete'

  get 'user_preferences/create'

  get 'user_preferences/show'

  get 'user_preferences/update'

  get 'user_preferences/delete'

  get 'user_profiles/create'

  get 'user_profiles/show'

  get 'user_profiles/update'

  get 'user_profiles/delete'

#devise_for :users
  root 'api/v0/sessions#create'

  # API related routes
  namespace :api, :defaults => {:format => :json} do  # url: domain/api
    namespace :v0 do  # full path version number /api/v0/
    #scope module: :v0, constraints: APIConstraints.new(version: 0, default: true) do # with constraints - no need to specif api/v0/ api/ is enough

    # root ---------------
      root 'sessions#create'

      # DEVISE ---------------
      devise_for :users, skip: :all
      devise_scope :api_v0_user do
        post 'signup' => 'registrations#create', :as => :user_registration
        post 'signin' => 'sessions#create', :as => :user_session
        delete 'signout' => 'sessions#destroy', :as => :destroy_user_session
      end

      # RESOURCES ---------------
      # users
      #post 'users/create' => 'users#create'
      post 'users/show' => 'users#show'
      post 'users/update' => 'users#update'
      #post 'users/delete' => 'users#delete'

      #user profiles
      post 'user_profiles/create' => 'user_profiles#create'
      post 'user_profiles/show' => 'user_profiles#show'
      post 'user_profiles/update' => 'user_profiles#update'
      #post 'user_profiles/delete' => 'user_profiles#delete'

      #user preferences
      post 'user_preferences/create' => 'user_preferences#create'
      post 'user_preferences/show' => 'user_preferences#show'
      post 'user_preferences/update' => 'user_preferences#update'
      ##post 'user_preferences/delete' => 'user_preferences#delete'

      #user pictures
      post 'user_pictures/create' => 'user_pictures#create'
      post 'user_pictures/show' => 'user_pictures#show'
      post 'user_pictures/update' => 'user_pictures#update'
      post 'user_pictures/delete' => 'user_pictures#delete'

      #user ratings
      post 'user_ratings/create' => 'user_ratings#create'
      post 'user_ratings/show' => 'user_ratings#show'
      post 'user_ratings/update' => 'user_ratings#update'
      ##post 'user_ratings/delete' => 'user_ratings#delete'

      #user matches
      post 'user_matches/create' => 'user_matches#create'
      post 'user_matches/show' => 'user_matches#show'
      post 'user_matches/update' => 'user_matches#update'
      #post 'user_matches/delete' => 'user_matches#delete'

      #user messages
      post 'user_messages/create' => 'user_messages#create'
      post 'user_messages/show' => 'user_messages#show'
      #post 'user_messages/update' => 'user_messages#update'
      ##post 'user_messages/delete' => 'user_messages#delete'
      
      #flagged users
      post 'flagged_users/create' => 'flagged_users#create'
      #post 'flagged_users/show' => 'flagged_users#show'
      #post 'flagged_users/update' => 'flagged_users#update'
      ##post 'flagged_users/delete' => 'flagged_users#delete'

      #user blacklists
      post 'user_blacklists/create' => 'user_blacklists#create'
      #post 'user_blacklists/show' => 'user_blacklists#show'
      #post 'user_blacklists/update' => 'user_blacklists#update'
      ##post 'user_blacklists/delete' => 'user_blacklists#delete'

      #quizzes
      post 'quizzes/create' => 'quizzes#create'
      post 'quizzes/show' => 'quizzes#show'
      post 'quizzes/update' => 'quizzes#update'
      #post 'quizzes/delete' => 'quizzes#delete'

    end
  end

  # for sidekiq monitoring
  # require 'sidekiq/web'
  # map '/sidekiq' do
  # use Rack::Auth::Basic, "Protected Area" do |username, password|
  # username == 'swayamvara-admin' && password == 'freelogue2014'
  # end

  # catch all routes
  match "*all" , :to => 'application#routing_error', :via => :all, :defaults => {:format => :json}
end

=begin
# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'

# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Example resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Example resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Example resource route with more complex sub-resources:
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', on: :collection
#     end
#   end

# Example resource route with concerns:
#   concern :toggleable do
#     post 'toggle'
#   end
#   resources :posts, concerns: :toggleable
#   resources :photos, concerns: :toggleable

# Example resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end
=end

