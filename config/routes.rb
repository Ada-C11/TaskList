# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/todos', to: 'todos#index', as: 'todos'

  get '/todos/new', to: 'todos#new', as: 'new_task'
  post '/todos', to: 'todos#create'

  get '/todos/:id', to: 'todos#show', as: 'todo'
  # patch '/todo/:id/read', to: 'todo#mark_complete', as: 'mark_complete'

  get '/todos/:id/edit', to: 'todos#edit', as: 'edit_task'
  patch '/todos/:id', to: 'todos#update'

  delete '/todos/:id', to: 'todos#destroy'

  root to: 'todos#index'
end
