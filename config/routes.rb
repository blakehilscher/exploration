ExplorationFitness::Application.routes.draw do
  
  root :to => "pages#home"
  devise_for :admins
  
  resources :registrations, :only => [:new, :create]
  match '/registrations', :to => 'registrations#new'
  
  namespace :admin do
    resources :slideshows 
    resources :photos  do
      post :sortable, on: :collection
    end
    resources :pages do
      resources :page_snippets
      post :sortable, on: :collection
    end
    resources :quotations do
      post :sortable, on: :collection
    end
    resources :itineraries do
      post :sortable, on: :collection
    end
    resources :bios do
      post :sortable, on: :collection
    end
    resources :slideshows do
      resources :slides do
        post :sortable, on: :collection
        resources :slide_photos do
          post :sortable, on: :collection
        end
      end
    end
    
    namespace :forms do
      resources :registrations
    end
    
    root :to => "pages#index"
  end
  
  
  get "pages/home"
  get "pages/coming_soon"
  get "pages/fitness"
  get "pages/our_tours"
  get "pages/our_team"
  get "pages/photos"
  get "pages/contact_us"
  get "pages/trip_itinerary"
  get "pages/packages"
  get "pages/newsletter"
  get "pages/thanks"
  
  match '/contact_us', :to => 'pages#contact_us'
  match '/coming_soon',:to => 'pages#coming_soon'
  match '/our_team', :to => 'pages#our_team'
  match '/photos', :to => 'pages#photos'
  match '/fitness', :to => 'pages#fitness'
  match '/our_tours',:to =>'pages#our_tours'
  match '/home',:to => 'pages#home'
  match '/trip_itinerary', :to => 'pages#trip_itinerary'
  match '/packages', :to => 'pages#packages'
  match '/newsletter', :to=> 'pages#newsletter'

  
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

