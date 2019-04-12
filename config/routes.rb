# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks
  # get '/tasks', to: task#index, as: tasks
  # To make the "complete_tasks_path", use syntax to create a route given some verb, path, controller, action, and name
end
