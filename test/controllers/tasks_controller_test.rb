# frozen_string_literal: true

require 'test_helper'

describe TasksController do
  let(:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: '07-13-2019'
  end
  describe 'index' do
    it 'can get the index path' do
      skip
      get tasks_path

      must_respond_with :success
    end

    it 'can get the root path' do
      skip
      get root_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'can get a valid task' do
      skip
      get task_path(task.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      skip
      get task_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new task page' do
      skip
      get new_task_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new task' do
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: '07-13-2019'
        }
      }

      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe 'edit' do
    it 'can get the edit page for an existing task' do
      skip
      get edit_task_path(task)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      skip
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'update' do
    it 'can update an existing task' do
      skip
      task = Task.create!(name: 'Do dishes')
      task_data = {
        task: {
          name: "Don't do dishes"
        }
      }

      # Act
      patch task_path(task), params: task_data

      # Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it 'will redirect to the root page if given an invalid id' do
      skip
      get task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'removes the task from the database' do
      skip
      task = Task.create!(name: 'Do laundry')

      expect do
        delete task_path(task)
      end.must_change 'Task.count', -1

      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns a 404 if the task does not exist" do
      task_id = 123456

      expect(Task.find_by(id: task_id)).must_be_nil

      expect {
        delete task_path(task_id)
      }.wont_change "Task.count"

      # Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    # Your tests go here

    # Arrange

    # Act

    # Assert
  end
end
