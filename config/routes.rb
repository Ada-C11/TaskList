Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks

  patch "/tasks/:id", to: "tasks#update"
  patch "/tasks/:id/toggle", to: "tasks#toggle", as: "toggle"
end
