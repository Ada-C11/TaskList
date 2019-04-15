# frozen_string_literal: true

class TodosController < ApplicationController
  # Todos = ["take a shower", "drink coffee"]
  def index
    @todos = Todo.all
  end

  def show
    todo_id = params[:id].to_i
    @todo = Todo.find_by(id: todo_id)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(
      name: params['todo']['name'],
      completion_date: params['todo']['completion_date'],
      description: params['todo']['description']
    )
    if @todo.save
      redirect_to todos_path
    else
      render :new
    end
  end

  def edit
    @todo = Todo.find_by(
      id: params['id']
    )
    redirect_to todos_path if @todo.nil?
  end

  def update
    todo = Todo.find_by(id: params[:id])
    todo.update(todo_params)
    is_successful = todo.update(todo_params)
    if is_successful
      redirect_to todo_path(todo.id)
    else
      head :not_found
    end
  end

  def destroy
    todo = Todo.find_by(id: params[:id])
    if todo.nil?
      head :not_found
    else
      todo.destroy
      redirect_to todos_path
    end
  end

  # def mark_completed_task; end

  private

  def todo_params
    params.require(:todo).permit(:name, :description, :completion_date)
  end
end
