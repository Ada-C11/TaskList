class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:completion_date).reverse_order
  end

  def show
    @task = Task.find(params[:id])
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
