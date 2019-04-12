# frozen_string_literal: true

class TodosController < ApplicationController
  # Todos = ["take a shower", "drink coffee"]
  def index
    @todos = Todo.all
  end

  def show
    todo_id = params[:id].to_i
    @todos = Todo.find_by(id: todo_id)
    # puts '@tasssssk', @todo
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
end
