Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'rider_regs#index'

  get 'rider_regs/terms_of_entry'   => 'rider_regs#terms_of_entry', as: :rider_regs_terms
  put 'rider_regs/terms_of_entry'   => 'rider_regs#accept_terms'
  get 'rider_regs/registration_fee' => 'rider_regs#registration_fee', as: :rider_regs_fee
  put 'rider_regs/registration_fee' => 'rider_regs#pay_fee'#, as: :rider_regs_pay_fee
  
  resources :users do 
    resources :rider_regs, only: [:new]
  end

  resources :admin

  resources :rider_regs, except: [:new]
  
  resources :donations, except: [:new, :create]

  get 'rider_regs/:id/donations/new' => 'donations#new', as: :rider_reg_donations
  post 'rider_regs/:id/donations' => 'donations#create', as: :donations_create
 
  resources :ride_years


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
end
