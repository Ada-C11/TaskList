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
  end

  # Unskip these tests for Wave 2
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
      expect(flash[:error]).must_equal "Could not find task with id: -1"
    end
  end

  describe "create" do
    it "can get the new task page" do
      # Act
      get create_task_path

      # Assert
      must_respond_with :success
    end

    it "can create a new task" do
      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description"
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      # Completion dates for new tasks are nil since
      # they start out incomplete.
      assert_nil(new_task.completion_date)
      # I use completion date to track completion.
      # expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Act
      get edit_task_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find task with id: -1"
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # 'Let' makes tests shorter by reusing the same variable
    # across tests.
    let (:task_hash) {
      {
        id: task.id,
        task: {
          name: "update task",
          description: "update task description"
        },
      }
    }

    it "can update an existing task" do
      # Act-Assert
      #expect {
        patch update_task_path(task_hash[:id]), params: task_hash
      #}.must_change "Task.count", 0

      updated_task = Task.find_by(name: task_hash[:task][:name])
      expect(updated_task.description).must_equal task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(updated_task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      task_hash[:id] = -1

      # Act
      patch update_task_path(task_hash[:id]), params: task_hash

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find task with id: -1"
    end

    it "will throw a error if there is an invalid name" do
      # Arrange
      task_hash[:name] = 45

      # Act-Assert
      assert_raise(Exception) { patch update_task_path, params: task_hash }
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
