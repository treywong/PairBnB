Rails.application.routes.draw do
  get 'braintree/new'
  get 'edit/index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  #resource :listing, controller: "/listing", only: [:index]

  resources :users, controller: "users", only: [:create] do
  # resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/users/:id/edit" => "users#edit", as: "users_edit"
  patch "/users/:id" => "users#update", as: "users_update"

  get "/listing" => "listing#index", as: "listing"
  get "/listing/new" => "listing#new", as: "listing_new"
  post "/listing" => "listing#create", as: "listing_create"
  get "/listing/:id" => "listing#show"
  get "/listing/:id/edit" => "listing#edit", as: "listing_edit"
  patch "/listing/:id" => "listing#update", as: "listing_update"
  delete "/listing/:id" => "listing#destroy", as: "listing_destroy"

  get "/reservation" => "reservation#index", as: "reservation"
  get "/listing/:id/reservation/new" => "reservation#new", as: "reservation_new"
  post "/listing/:id/reservation" => "reservation#create", as: "reservation_create"
  get "/listing/:id/reservation/edit" => "reservation#edit", as: "reservation_edit"
  patch "/listing/:id/reservation" => "reservation#update", as: "reservation_update"
  delete "/reservation/:id" => "reservation#delete", as: "reservation_destroy"
  # post "/reservation/:id" => "reservation#delete", as: "reservation_delete"
  
  post 'braintree/checkout'=> "braintree#checkout", as: "braintree_checkout"

  get "/search" => "search#index", as: "search_index"
  post "/search" => "search#searching", as: "search_searching"
  get "/search/show" => "search#show", as: "search_show"


  get "/reservation/:id/bookings/confirm" => "bookings#confirmation", as: "bookings_confirm"
  get 'welcome/index'
  root 'welcome#index'

end
