

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    puts "Task ID was #{task_id}"
    puts "result of .to_i: #{task_id.to_i}"
    @task = Task.find_by(id: task_id)

    unless @task
      #head :not_found
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    unless params["task"]
      render :new, status: :bad_request
      return
    end
    @task.save
    redirect_to tasks_path
  end

  def edit
    @task = Task.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    unless task
      redirect_to tasks_path
      return
    end

    task.update!(task_params)
    redirect_to task_path(task)
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    unless @task
      head :not_found
      return
    end
    @task.destroy
    redirect_to tasks_path
  end

  # def complete
  #   @task = Task.find_by(id: params[:id])
  #   unless @task
  #     redirect_to tasks_path
  #     return
  #   end
  #   @task.completed = !@task.completed
  #   @task.save
  #   redirect_to root_path
  # end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
