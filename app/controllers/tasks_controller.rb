class TasksController < ApplicationController
  TASKS = [{ task: "make bed", done: false }, { task: "make lunch", done: false }, { task: "catch train", done: true }, { task: "be awesome", done: true }]

  def index
    @tasks = TASKS
  end
end
