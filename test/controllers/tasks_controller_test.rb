require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: Time.now + 5.days
  }

  # Tests for Wave 1
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

    it "renders without crashing" do
      # Arrange

      # Act
      get "/tasks"

      # Assert
      must_respond_with :ok
    end

    it "renders even when there is zero task" do
      Task.create!(name: "test task")

      get "/tasks"

      must_respond_with :ok
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find task with id: -1"
    end

    it "returns a 404 status code if the task doesn't exist" do
      # Fail case
      task_id = 12345

      get "/tasks/#{task_id}"

      must_respond_with :not_found
    end

    it "works for a task that exists" do

    end
  end
  
  describe "new" do
    it "can get the new task page" do
      skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      skip

      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.due_date.to_time.to_i).must_equal task_hash[:task][:due_date].to_i
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      skip
      # Your code here
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      skip
      # Your code here
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      skip
      # Your code here
    end

    it "will redirect to the root page if given an invalid id" do
      skip
      # Your code here
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
