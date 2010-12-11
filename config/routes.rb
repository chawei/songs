Songs::Application.routes.draw do
  resources :artists

  resources :authorizations
  resources :notes

  resources :background_stories

  resources :lyrics

  root :to => "home#index"
  
  match '/sidebar/show', :to => "sidebar#show"
  match '/sidebar/switch_video', :to => "sidebar#switch_video"
  match '/sidebar/load.:format', :to => "sidebar#load"
  match '/sidebar/sidebar.:format', :to => "sidebar#sidebar"
  
  match '/login', :to => 'user_sessions#new'
  match '/logout', :to => 'user_sessions#destroy'
  match '/signup', :to => 'users#new'
  match '/account', :to => "users#account"
  
  match "/auth/:provider/callback", :to => "authorizations#create"
  match "/auth/failure", :to => "authorizations#failure"
  
  post "votes/thumbs_up"
  post "votes/thumbs_down"

  resource :user_session
  resources :users, :constraints => { :id => /.*/ }
  resources :lyrics do
    resources :background_stories
    resources :notes
  end
  
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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
