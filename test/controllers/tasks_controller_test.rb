require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion: Time.now + 5.days
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      get tasks_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid task" do
      get task_path(task.id)
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get task_path(-1)
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      get new_task_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion: "2019-05-20",
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", +1

      task = Task.last
      expect(task.name).must_equal task_hash[:task][:name]
      expect(task.description).must_equal task_hash[:task][:description]
      expect(task.completion).must_equal Date.parse(task_hash[:task][:completion])

      must_respond_with :redirect
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    
    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1000)
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing task" do
      task = Task.create!(name: "study")
        task_info = {
          task: {
            name: "party",
          },
        }

        patch task_path(task), params: task_info

        must_respond_with :redirect
        must_redirect_to tasks_path

        task.reload
        expect(task.name).must_equal(task_info[:task][:name])
    end

    it "will redirect to the root page if given an invalid id" do
      get task_path(15000)
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do
      new_task = Task.create(name: "call dentist")

      expect {
        delete task_path(new_task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "marks a task complete with completion date" do
      patch toggle_path(task.id)
      task.reload
      expect(task.completed_at).wont_equal nil
    end
  end
end
