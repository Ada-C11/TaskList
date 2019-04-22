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
      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: nil,
          complete: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      expect(new_task.complete).must_equal task_hash[:task][:complete]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      patch task_path(task.id), params: {task: {name: "amy"}}
      assert_redirected_to task_path(task.id)
      task.reload
      assert_equal "amy", task.name
    end

    it "will redirect to the root page if given an invalid id" do
      invalid_id = "NOT A VALID ID"
      patch task_path(invalid_id)
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do
      new_task = Task.create(name: "Amy", description: "practice self care")
      expect {
        delete task_path(new_task.id)
      }.must_change "Task.count", -1
      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "returns a 404 if the task is not found" do
      invalid_id = "NOT A VALID ID"
      expect {
        delete task_path(invalid_id)
      }.wont_change "Task.count"
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "changes default status to true" do
      patch toggle_complete_path(task.id)
      assert_redirected_to tasks_path
      task.reload
      assert_equal true, task.complete
    end
    it "changes default status back to false" do
      patch toggle_complete_path(task.id)
      patch toggle_complete_path(task.id)
      assert_redirected_to tasks_path
      task.reload
      assert_equal false, task.complete
    end
  end
end
