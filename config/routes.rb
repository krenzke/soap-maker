Rails.application.routes.draw do
  resources :batch_line_items
  resources :batches
  resources :ingredient_purchases
  resources :ingredients

  root "pages#index"
end
