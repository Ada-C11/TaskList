class TasksController < ApplicationController
  TASKS = ["please please work", "more hoping", "etc"]

  def index
    @tasks = TASKS
  end
end
