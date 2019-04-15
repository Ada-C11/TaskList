require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test"
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
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]

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
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do

    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      to_be_updated_task = Task.first
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
        },
      }
      # Your code here

      expect {
        patch task_path(to_be_updated_task.id), params: task_hash
      }.wont_change "Task.count"

      to_be_updated_task.reload
      must_respond_with :redirect
      must_redirect_to task_path(to_be_updated_task.id)

      edited_task = Task.find_by(name: task_hash[:task][:name])
      expect(edited_task.name).must_equal "new task"
      expect(edited_task.description).must_equal "new task description"
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      patch task_path(800)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    task = Task.first
    it "can delete the task" do
      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "redirects to root path if the id is invalid" do
      delete task_path(-1)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    it "changes the completion date to today's date" do
      task = Task.first
      task_hash = {
        task: {
          completion_date: DateTime.now.to_date,
        },
      }
      expect {
        patch toggle_complete_path(task.id), params: task_hash
      }.wont_change "Task.count"

      toggled_task = Task.find_by(id: task_hash[:task][:id])
      expect(toggled_task.completion_date).must_equal DateTime.now.to_date
    end

    it "redirects to root path if the id is invalid" do
      patch task_path(-1)
      must_redirect_to root_path
    end
  end
end
