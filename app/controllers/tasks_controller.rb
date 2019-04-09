class TasksController < ApplicationController
  TASKS = [
    {todo: "Task List Project", when: "today"},
    {todo: "Groceries", when: "Friday"},
  ]

  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
  end
end
