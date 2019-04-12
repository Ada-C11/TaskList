class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:name)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    head :not_found if @task.nil?
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
    )

    if task.save
      redirect_to task_path(task.id)
    else
      head :bad_request
    end
  end

  def edit
    task_id = params[:id]
    # @book = Book.new(title: "Default Title")
    @task = Task.find_by(id: task_id)

    head :not_found if @task.nil?
  end

  def update
    task_id = params[:id]
    task = Task.find_by(id: task_id)
    task.name = params[:task][:name]
    task.description = params[:task][:description]

    if task.save
      redirect_to task_path(task.id)
    else
      head :bad_request
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])
    config.time_zone = "Pacific Time (US & Canada)"

    if task.nil?
      head :not_found
    elsif !task.completed
      task.completed = true
      task.completion_date = Date.today
      task.save
    else
      task.completed = false
      task.save
    end
    redirect_to tasks_path
  end
end
