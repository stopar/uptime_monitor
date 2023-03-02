Rails.application.routes.draw do
  resources :domains, only: [:new, :create, :update, :show] do
    resources :pings, only: [:create]
  end
  root "site#index"
end
