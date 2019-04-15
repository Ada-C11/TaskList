Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch "tasks/:id/toggle", to: "tasks#toggle", as: "current_status"
  root to: "tasks#index", as: "root"
  resources :tasks
end
