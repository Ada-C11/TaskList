class TasksController < ApplicationController
  TASKS = [{task: "water pothos", status: "complete"}, {task: "make dinner", status: "incomplete"}, {task: "finish hw", status: "incomplete"}]

  def index
    @tasks = TASKS
  end
end
