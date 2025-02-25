Rails.application.routes.draw do
  # resources :batch_line_items
  resources :batches do
    resources :images, only: [:destroy]
  end
  resources :ingredient_purchases, path: :purchases
  resources :ingredients

  get :labels, to: "labels#index"
  post :labels, to: "labels#show"

  root "pages#index"
end
