Rails.application.routes.draw do
  resources :batches do
    resources :images, only: [:destroy]
  end
  resources :ingredients
  resources :recipes

  root "pages#index"
end
