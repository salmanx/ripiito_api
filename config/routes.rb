# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tenants, only: %i[show create]
  resources :plans, only: %i[show create]
  resources :packages, only: %i[show create]

  get 'up' => 'rails/health#show', as: :rails_health_check
end
