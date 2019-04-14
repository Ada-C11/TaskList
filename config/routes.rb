Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"

  resources :tasks

  patch "task/:id/toggle_complete", to: "tasks#toggle_complete", as: "toggle_complete_task"
end
