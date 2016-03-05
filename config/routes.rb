Rails.application.routes.draw do

  resources :security_groups
  root to: 'visitors#index'

  get    "savings"             => "visitors#savings"		
  get    "settings"             => "visitors#settings"		
  get    "dashboard"             => "visitors#dashboard"		

  get 'inspectors/security'
  get 'inspectors/cost'

end
