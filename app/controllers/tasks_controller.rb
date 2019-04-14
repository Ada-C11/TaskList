class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to action: 'index', status: 302
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      render :show
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      flash[:error] = "That task does not exist."
      redirect_to action: 'index', status: 302
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to tasks_path
    else  task.update(task_params)
        flash[:success] = "Successful Update!"
        redirect_to task_path(task.id)
    end
  end


  def complete
    task = Task.find_by(id: params[:id])

    if task.completed
      task.update(
        completed: !task.completed
      )
    else
      task.update(
        completed: !task.completed,
        completion_date: DateTime.now
      )
    end

    task.save
    redirect_to tasks_path
  end


  def destroy
    task = Task.find_by(id: params[:id] )
    if task.nil?
      head :not_found
    else
      task.destroy 
      redirect_to tasks_path
    end
  end

  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end

end
