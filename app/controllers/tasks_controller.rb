TASKS = ["walk the dog", "brush teeth", "do homework", "go for a jog"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
