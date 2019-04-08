TASKS = ["Feed Cat", "Fold Laundry", "Wash Dishes"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
