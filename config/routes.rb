Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  patch "/tasks/:id/complete", to: "tasks#complete", as: "complete"
end
