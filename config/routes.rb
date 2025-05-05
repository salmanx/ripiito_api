# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tenants
  post 'plans', to: 'plans#create'
  get 'plans/:id', to: 'plans#show'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
