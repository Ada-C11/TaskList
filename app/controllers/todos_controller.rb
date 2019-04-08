class TodosController < ApplicationController
  TASKS = ["take a shower", "drink coffee"] 
  def index
    @tasks = TASKS
  end
end
