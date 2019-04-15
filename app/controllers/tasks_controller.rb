class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to action: "index", status: 302
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    if task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to action: "index", status: 302
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to action: "index", status: 302
    else
      task.update(task_params)
      redirect_to task_path(task.id)
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to action: "index", status: 302
    else
      task.destroy
      redirect_to root_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_date)
  end
end
