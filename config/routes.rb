# frozen_string_literal: true

Rails.application.routes.draw do
  # get "/books", to: 'books#show'
  get '/todos/:id', to: 'todos#show', as: 'todos'
  get '/todos', to: 'todos#index'
  root to: 'todos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
