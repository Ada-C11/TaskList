Rails.application.routes.draw do
  root to: "tasks#index"
  patch "/tasks/:id/complete", to: "tasks#mark_complete", as: "mark_complete"
  resources :tasks
end
