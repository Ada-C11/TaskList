class TasksController < ApplicationController
  TASKS = [
    {todo: "Task List Project", when: "today"},
    {todo: "Groceries", when: "Friday"},
  ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
    end
  end
end
