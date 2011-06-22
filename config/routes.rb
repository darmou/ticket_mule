TicketMule::Application.routes.draw do
  root :to => "dashboard#index"

  match '/login', :to => 'user_sessions#new', :as => :login
  match '/logout', :to => 'user_sessions#destroy', :as => :logout

  resources :tickets, :has_many => [:comments, :attachments]


  match 'tickets/set_tickets_per_page/:per_page', :to => 'tickets#set_tickets_per_page'
  match 'attachments/:ticket_id/:id', :via => :get, :to => 'attachments#show'

  resources :dashboard, :only => :index

  resources :users do
    member do
      post 'toggle'
      post 'unlock'
    end
  end

  resources :contacts do
    member do
      post 'toggle'
    end
  end

  resource :user_session
  resources :password_resets
  resources :alerts


  scope '/admin', :name_prefix => 'admin' do
    match '/', :to => 'admin#index', :via => :get, :as => :index
    match '/add_group', :to => 'admin#add_group' ,:via => :post, :as => :add_group
    match '/add_status', :to => 'admin#add_status', :via => :post, :as => :add_status
    match '/add_priority', :to => 'admin#add_priority', :via => :post, :as => :add_priority
    match '/add_user', :to => 'admin#add_user', :via => :post, :as => :add_user
    match '/toggle_group', :to => 'admin#toggle_group', :via => :post, :as => :toggle_group
    match '/toggle_status', :to => 'admin#toggle_status', :via => :post, :as => :toggle_status
    match '/toggle_priority', :to => 'admin#toggle_priority', :via => :post, :as => :toggle_priority
  end

  match '*url', :to => 'dashboard#index'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
