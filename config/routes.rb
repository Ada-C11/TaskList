# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  # routes that operate on the task collection
  root 'tasks#index'
  resources :tasks
  put 'tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete'
  
end
