TASKS = [
  {task_name: "Task List Project", status: "in progress"},
  {task_name: "CS Fun reading", status: "not started"},
  {task_name: "CS Fun PR", status: "not started"},
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
