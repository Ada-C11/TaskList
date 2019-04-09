


class TasksController < ApplicationController

    def index
        @tasks = TASKS
     
    end

def show
    task_id = params[:id]
    puts "Task ID was #{task_id}"
    puts "result of .to_i: #{task_id.to_i}"
    @task = TASKS[task_id.to_i]

    unless @task
        head :not_found
    end
end

end
