# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tenants

  get 'up' => 'rails/health#show', as: :rails_health_check
end
