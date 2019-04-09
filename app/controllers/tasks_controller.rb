class TasksController < ApplicationController
  def index
    # add an instance variable here
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      head :not_found # barely step above raising an exception. 
    end
  end
end
