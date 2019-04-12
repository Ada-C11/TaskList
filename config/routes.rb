# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/todos', to: 'todos#index', as: 'todos'

  get '/todos/new', to: 'todos#new', as: 'new_task'
  post '/todos', to: 'todos#create'

  get '/todos/:id', to: 'todos#show', as: 'todo'
  # patch '/todo/:id/read', to: 'todo#mark_complete', as: 'mark_complete'

  root to: 'todos#index'
end
