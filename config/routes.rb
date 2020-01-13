Rails.application.routes.draw do
  resources :campaigns do
    resources :campaign_products, except: [:index, :show]
  end
  get 'customer_campaigns/list' => 'customer_campaigns#list'
  get 'customer_campaigns/selected' => 'customer_campaigns#selected'
  resources :customer_campaigns do
    resources :campaign_activities, except: [:index, :show]
  end
  devise_for :users
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'customer_campaigns#index'
end
