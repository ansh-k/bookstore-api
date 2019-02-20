Rails.application.routes.draw do
  resources :publishing_houses
  resources :authors
  resources :books
  post 'author_webhook', to: 'github_webhooks#author_webhook'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
