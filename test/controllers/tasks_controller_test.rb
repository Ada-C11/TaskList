require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: Date.current
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
      # skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with 302 for an invalid task" do
      # skip
      # Act
      expect {
        get task_path(-1)
      }.wont_change "Task.count"

      # Assert
      must_respond_with 302
    end
  end

  describe "new" do
    it "can get the new task page" do
      # skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      # skip

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: Date.current,
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
      must_redirect_to root_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      get edit_task_path(task.id)

      must_respond_with :success
    end

    it "will respond with 302 when attempting to edit a nonexistant task" do
      # skip
      expect {
        get edit_task_path(-1)
      }.wont_change "Task.count"

      must_respond_with 302
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      # skip
      original_task = Task.create!(
        name: "new task",
        description: "new task description",
        completion_date: Date.current,
      )

      new_hash = {
        task: {
          name: "new task name",
        },
      }

      expect {
        patch task_path(original_task.id), params: new_hash
      }.wont_change "Task.count"

      original_task.reload
      expect(original_task.name).must_equal "new task name"
    end

    it "will respond with 302 if invalid id" do
      # skip
      expect {
        patch task_path(-1)
      }.wont_change "Task.count"

      must_respond_with 302
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "will will respond with 302 if ID is invalid" do
      invalid_id = "NOT A VALID ID"

      expect {
        delete task_path(invalid_id)
      }.wont_change "Task.count"
      must_respond_with 302
    end

    it "can delete a task" do
      new_task = Task.create(name: "start code hw")

      expect {
        delete task_path(new_task)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "will update the completion date when complete" do
      new_task = Task.create(name: "dance")

      patch mark_complete_path(new_task.id)
      new_task.reload

      expect(new_task.completion_date).must_equal Date.current
    end

    it "will respond with 302 if ID is invalid for completed task" do
      invalid_id = "NOT A VALID ID"

      patch mark_complete_path(invalid_id)
      must_respond_with 302
    end

    it "will respond with 302 if ID is invalid for incompleted task" do
      invalid_id = "NOT A VALID ID"

      patch mark_incomplete_path(invalid_id)
      must_respond_with 302
    end

    it "will change the completion date to nil when marked incomplete" do
      new_task = Task.create(name: "Cook")

      patch mark_incomplete_path(new_task.id)
      new_task.reload

      expect(new_task.completion_date).must_be_nil
    end
  end
end
