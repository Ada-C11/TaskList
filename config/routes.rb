Rails.application.routes.draw do
  root to: "tasks#index"

  resources :tasks

  patch "/tasks/:id/toggle", to: "tasks#toggle", as: "toggle"
end
