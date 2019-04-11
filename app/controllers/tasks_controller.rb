class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:completion_date).reverse_order
  end

  def show
    @task = Task.find(params[:id])
  end
end
