Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :listing_integrations, as: :integrations
  end

  resources :integrations

  devise_for :users

  root to: "pages#home"
end
