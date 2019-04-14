Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks
  patch "/tasks/:id", to: "tasks#toggle_complete", as: "toggle_complete_task"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
