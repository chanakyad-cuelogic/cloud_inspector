Rails.application.routes.draw do
  resources :security_groups
  root to: 'visitors#index'
end
