Rails.application.routes.draw do
  resources :meeting_plans
  resources :meetings
  resources :projects
  root 'dashboard#index'

  devise_for :users
  resources :employees
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
