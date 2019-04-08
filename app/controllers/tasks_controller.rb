class TasksController < ApplicationController
  TASKS = ["wake up", "make bed", "brush teeth", "wash face", "make coffee"]

  def index
    @tasks = TASKS
  end
end
