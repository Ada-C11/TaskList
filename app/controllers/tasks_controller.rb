class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new
    
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    if params[:task][:date]
      @task.date = Date.parse(params[:task][:date])
    end

    task.save

    redirect_to tasks_path
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    @task.update(task_params)

    redirect_to task_path(@task)
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    task.destroy 

    redirect_to tasks_path
  end

  def complete
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    task.completed = !task.completed

    if task.completed
      task.completion_date = Date.today
    else
      task.completion_date = nil
    end

    task.save
    redirect_to tasks_path
  end

  private
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
