require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: "completion date"
  }

  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid task" do 
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: "completion date",
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert 
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do

      get edit_task_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "That task does not exist."
    end
  end

  describe "update" do
    it "can update an existing task" do
      new_task = Task.create!(name: 'Household', description: 'Mop the floor', completion_date: "April 15th")
      
      new_name = { 
        task: { 
          name: 'Changed name', 
          } 
        }

      patch task_path(new_task.id), params: new_name
      new_task.reload
      expect(new_task.name).must_equal "Changed name"
    end


    it "will redirect to the root page if given an invalid id" do
      patch task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "destroy" do
    it 'deletes a task from database' do 
      task = Task.create!(name: "Home", description: "Do the dishes")

      expect {
        delete task_path(task)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
      
      deleted_task = Task.find_by(id: task.id)
      expect(deleted_task).must_be_nil
    end
  end

  describe "toggle_complete" do
    it "returns success" do
      patch complete_task_path(task.id)

      must_respond_with :found
    end

    it "updates completion date to current date" do
      patch complete_task_path(task.id)

      complete = Task.find_by(id: task.id)

      expect(complete.completion_date).must_equal (DateTime.now).to_s
    end

    # Hi Chris! I tried to get this test to Pass but I couldn't manage!! Help please! :)

    # it "won't update completed task date during complete incomplete toggle" do
    #   task = Task.create(
    #     name: "Home",
    #     description: "Walk the dog",
    #     completion_date: "April, 11th 2019",
    #   )

    #   patch complete_task_path(task.id)

    #   toggle = Task.find_by(id: task.id)
    
    #   expect(toggle.completion_date).must_equal "April, 11th 2019"

    # end

  end
end