Pierco::Application.routes.draw do

  get "login/login"
  get "main/index"
  get "login/logout"
  post "login/login"
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
  
  namespace 'admin' do 
    resources :companies
    resources :contacts
    resources :distributors
    resources :posts
    resources :products do
      resources :product_dimensions
      collection do
        get 'lookup'
        post 'lookup'
      end
    end      
    resources :product_categories do
      resources :product_subcategories
    end
    resources :suppliers
    resources :supplier_contacts
    resources :users
  end

  resources :contacts

  controller :main do
    get 'index' 
  end  

  controller :store do
    get 'index' => :index
    get 'about_us' => :about_us
    get 'suppliers' => :suppliers
    get 'products' => :products
    get 'distributors' => :distributors
    get 'contact_us' => :contact_us
    get 'view_product' => :view_product
    get 'thank_you' => :thank_you
    post 'create_contact' => :create_contact
  end
  
  root :to => "store#index", :as => 'store'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
  #match ':controller/:action.:format'

 

end
