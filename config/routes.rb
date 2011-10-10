TicketMuleRails31::Application.routes.draw do
  
  #match '/' => 'dashboard#index'
  
  root :to => 'dashboard#index'
  
  

  match "login" => "user_sessions#new", :as => :login
  match "logout" => "user_sessions#destroy", :as=>:logout

  resources :tickets, :has_many => [:comments, :attachments]
  match "ticket/comments" => "ticket#comments", :as => :ticket_comments
  match "ticket/attachments" => "ticket#attachments", :as => :ticket_attachments
  
  
  match "tickets/set_tickets_per_page/:per_page" => "tickets#set_tickets_per_page", :as => :per_page
  
  match "attachments/:ticket_id/:id" => "attachments#show", :as => :show, :conditions => { :method => :get }

  resources :dashboard, :only => :index

  # users can add themselves
  resources :users, :member => { :toggle => :post, :unlock => :post }
  match 'contacts/toggle_user' => 'contacts#toggle_user', :as => :toggle_user

  # only admins can add users
  #resources :users, :member => { :toggle => :post, :unlock => :post }, :except => :new

  resources :contacts, :member => { :toggle => :post }
  match 'contacts/toggle_contact' => 'contacts#toggle_contact', :as => :toggle_contact

  resource :user_session

  resources :password_resets

  resources :alerts

  
  match "admin" => "admin#index", :as => :admin_index
  match "admin/add_group" => "admin#add_group", :as => :add_group
  match "admin/add_status" => "admin#add_status", :as => :add_status
  match "admin/add_priority" => "admin#add_priority", :as => :add_priority
  match "admin/add_time_type" => "admin#add_time_type", :as => :add_time_type
  
  match "admin/add_user" => "admin#add_user", :as => :add_user
  match "admin/toggle_group" => "admin#toggle_group", :as => :toggle_group
  match "admin/toggle_status" => "admin#toggle_status", :as => :toggle_status
  match "admin/toggle_priority" => "admin#toggle_priority", :as => :toggle_priority
  match "admin/toggle_time_type" => "admin#toggle_time_type", :as => :toggle_time_type
  match "admin/reports" => "admin#reports", :as => :reports
  
  #with_options :controller => 'admin' do |a|
  #  a.admin_index '/admin', :action => 'index', :conditions => { :method => :get }
  #  a.add_group '/admin/add_group', :action => 'add_group', :conditions => { :method => :post }
  #  a.add_status '/admin/add_status', :action => 'add_status', :conditions => { :method => :post }
  #  a.add_priority '/admin/add_priority', :action => 'add_priority', :conditions => { :method => :post }
  #  a.add_time_type '/admin/add_time_type', :action => 'add_time_type', :conditions => { :method => :post }
  #  a.add_user '/admin/add_user', :action => 'add_user', :conditions => { :method => :post }
  #  a.toggle_group '/admin/toggle_group', :action => 'toggle_group', :conditions => { :method => :post }
  #  a.toggle_status '/admin/toggle_status', :action => 'toggle_status', :conditions => { :method => :post }
  #  a.toggle_priority '/admin/toggle_priority', :action => 'toggle_priority', :conditions => { :method => :post }
  #  a.toggle_time_type '/admin/toggle_time_type', :action => 'toggle_time_type', :conditions => { :method => :post }
  #  a.reports '/admin/reports', :action => 'reports', :conditions => { :method => :post }
  #end

  match "*url" => "dashboard#index", :as => :index
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
