Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  root to: "tasks#index"
  patch "/tasks/:id/complete", to: "tasks#toggle_complete", as: "toggle_complete"
end
