class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:completion_date).reverse_order
  end

  def show
    task_id =  params[:id]
    @task = Task.find_by(id: task_id)
    flash[:error] = "Could not find task with id: #{task_id}"
    redirect_to tasks_path unless @task
  end

  def new
    @task = Task.new
  end

  def create
    new_task = Task.new(name: params[:task][:name],
                        description: params[:task][:description],
                        priority: params[:task][:priority])
    #error handle when saving incase unsuccessful
    if new_task.save
      redirect_to task_path(new_task)
    else
      head :not_found
    end
  end
end
