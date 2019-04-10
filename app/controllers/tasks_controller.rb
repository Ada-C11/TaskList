


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
        head :not_found
    end
end

end
