Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index'
  
  # root :to => "tasks#index"

  
end
