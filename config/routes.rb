Fairnopoly::Application.routes.draw do

  resources :auction_templates, :except => [:show, :index]

  mount Tinycms::Engine => "/cms"

  ActiveAdmin.routes(self)

  get "invitation/index"

  
  resources :images
  resources :invitations
  resources :ffps
    
  #devise_for :user
  devise_for :user, controllers: { registrations: 'registrations' }

  resources :auctions do
  #recources :userevents

    member do
      get 'activate'
      get 'deactivate'
      get 'report'
      post 'follow'
      post 'stop_follow'
      post 'collect'
      post 'add_to_library'
    end
    collection do
      get 'sunspot_failure'
      get 'autocomplete'
    end
  end

  resources :messages

  get "welcome/index"

  #the user routes
  match 'dashboard' => 'dashboard#index'
  match 'dashboard/search_users' => 'dashboard#search_users'
  match 'search_users' => 'dashboard#search_users'
  match 'dashboard/admin' => 'dashboard#admin'
  
  match 'dashboard/follow' => 'dashboard#follow'
  match 'dashboard/stop_follow' => 'dashboard#stop_follow'
  
  match 'dashboard/list_followers' => 'dashboard#list_followers'
  match 'dashboard/list_following' => 'dashboard#list_following'
  match 'community' => 'dashboard#community'
  
  get 'dashboard/profile'
  get 'dashboard/edit_profile'
  get 'dashboard/sales' 
  get 'dashboard/libraries'
  post 'dashboard/add_to_library'
  post 'dashboard/new_library'
  get 'dashboard/delete_library_element'
  get 'dashboard/set_library_public' 
  get 'dashboard/set_library_private' 
   
  #match 'autocomplete_user_name' => 'dashboard#autocomplete_user_name'
  #confirmation invitation
  match 'confirm_invitation' => 'invitations#confirm'

  match 'invitation' => 'invitations#new'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

#root :to => 'dashboard#index'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
  scope :constraints => lambda {|request|
    request.params[:id] && !["assets","system","admin","public","favicon.ico"].any?{|url| request.params[:id].match(/^#{url}/)}
  } do
    match "/*id" => 'tinycms/contents#show'
  end
end
