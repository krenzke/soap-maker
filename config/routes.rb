Rails.application.routes.draw do
  resources :batches do
    resources :images, only: [:destroy]
    post :duplicate
  end
  resources :ingredients
  resources :recipes

  root "batches#index"
end
