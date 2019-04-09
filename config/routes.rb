Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index'
  get '/tasks/:id', to: 'tasks#show'

  root to: "tasks#index"
end
