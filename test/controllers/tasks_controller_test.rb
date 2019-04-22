require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed_at: "", completion_date: ""
  }

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
          completed_at: "",
          completion_date: ""
        },
      }

      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])

      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed_at).must_equal task_hash[:task][:completed_at]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

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

  describe "update" do
    task_hash = {
      task: {
        name: "new task",
        description: "new task description",
        completed_at: "",
        completion_date: ""
      },
    }

    it "can update an existing task" do
      id = Task.first.id
      expect {
        patch task_path(id), params: task_hash
      }.wont_change "Task.count"
    end

    it "will redirect to the root page if given an invalid id" do
      patch task_path(-1), params: task_hash
      
      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "returns a 404 if the task if not found" do
      invalid_id = "NOT A VALID ID"

      expect {
        delete task_path(invalid_id)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end

    it "can delete a book" do
      new_task = Task.create(name: "Call Sister")

      expect {
        delete task_path(new_task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "toggle_complete" do
    task_hash = {
      task: {
        name: "new task",
        description: "new task description",
        completed_at: "",
        completion_date: ""
      },
    }

    it "will change completion status of an existing task" do
      id = Task.first.id
      expect {
        patch toggle_complete_path(id), params: task_hash
      }.wont_change "Task.count"
    end

    it "will change completion status" do
      task = Task.first
      status = Task.first.completed_at

      expect {
        patch toggle_complete_path(task.id), params: task_hash
      }.must_change task.completed_at
    end 
  end
end