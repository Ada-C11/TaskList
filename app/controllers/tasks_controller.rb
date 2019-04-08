class TasksController < ApplicationController
  TASKS = [
    "get groceries", "go clothing shopping", "walk the dog"    
  ]
  
  def index
    @tasks = TASKS
  end
end
