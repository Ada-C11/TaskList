Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks
  patch "/tasks/:id/mark_done", to: "tasks#mark_done", as: "marked_task"


  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
