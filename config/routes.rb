Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rename_column_password_digests
  get "login/login"
  get "login/logout"
  post "login/login"
  namespace 'admin' do 
      resources :companies
      resources :contacts
      resources :distributors do
        collection do
          get 'lookup'
          post 'lookup'
        end 
      end
      resources :posts
      resources :products do
        collection do
          get 'lookup'
          post 'lookup'
          post 'search'
        end 
        resources :product_dimensions
        resources :product_photos
      end      
      resources :product_categories do
        resources :product_subcategories
      end
      resources :suppliers
      resources :supplier_contacts
      resources :users
    end

    resources :contacts

    controller :store do
      get 'index', action: 'index'
      get 'about_us', action: 'about_us'
      get 'suppliers', action: 'suppliers'
      get 'products', action: 'products'
      #get 'distributors', action: 'distributors'
      get 'contact_us', action: 'contact_us'
      get 'view_product', action: 'view_product'
      get 'thank_you', action: 'thank_you'
      post 'create_contact', action: 'create_contact'
      get 'product_modal', action: 'product_modal'
    end
  
    root :to => "store#index", :as => 'store'
end
