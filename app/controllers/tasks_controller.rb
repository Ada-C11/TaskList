class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end

    if @task.completed
      @status = "completed"
    elsif @task.due_date && @task.due_date < DateTime.now
      @status = "overdue"
    else
      @status = "in-progress"
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      due_date: params[:task][:due_date],
    )

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found # refactor this
    end
  end
end
