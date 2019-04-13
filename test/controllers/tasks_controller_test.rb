# frozen_string_literal: true

require 'test_helper'

describe TasksController do
  let(:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: '2019-07-13', is_complete: false
  end
  describe 'index' do
    it 'can get the index path' do
      get tasks_path

      must_respond_with :success
    end

    it 'can get the root path' do
      get root_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'can get a valid task' do
      get task_path(task.id)

      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      get task_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new task page' do
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
          completion_date: '2019-04-23'
        }
      }
      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date.strftime('%Y-%m-%d')).must_equal task_hash[:task][:completion_date]
      expect(new_task.is_complete).must_equal false

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe 'edit' do
    it 'can get the edit page for an existing task' do
      get edit_task_path(task)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'update' do
    it 'can update an existing task' do
      task = Task.create!(name: 'Do dishes')
      task_data = {
        task: {
          name: "Don't do dishes"
        }
      }

      patch task_path(task), params: task_data

      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it 'will redirect to the root page if given an invalid id' do
      get task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe 'destroy' do
    it 'removes the task from the database' do
      task = Task.create!(name: 'Do laundry')

      expect do
        delete task_path(task)
      end.must_change 'Task.count', -1

      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it 'returns a 404 if the task does not exist' do
      task_id = 123_456

      expect(Task.find_by(id: task_id)).must_be_nil

      expect do
        delete task_path(task_id)
      end.wont_change 'Task.count'

      must_respond_with :not_found
    end
  end

  describe 'toggle_complete' do
    it 'can mark a task as complete or incomplete' do
      patch toggle_path(task.id)

      first_toggle = Task.find_by(id: task.id)

      expect(first_toggle.is_complete).must_equal true

      patch toggle_path(task.id)

      second_toggle = Task.find_by(id: task.id)

      expect(second_toggle.is_complete).must_equal false

    end

    it 'can mark a task as complete or incomplete' do
      patch toggle_path(task.id)

      first_toggle = Task.find_by(id: task.id)

      expect(first_toggle.is_complete).must_equal true

      patch toggle_path(task.id)

      second_toggle = Task.find_by(id: task.id)

      expect(second_toggle.is_complete).must_equal false

    end

    it 'can update the date of a completed task to the current date' do
      patch toggle_path(task.id)

      toggle = Task.find_by(id: task.id)

      expect(toggle.completion_date.strftime('%Y-%m-%d')).must_equal DateTime.now.strftime('%Y-%m-%d')
    end

    it 'doesnt update completed task date when going from complete to incomplete' do
        task = Task.create!(
          name: 'Do dishes', 
          completion_date: '2019-07-13', 
          is_complete: true
          )

      patch toggle_path(task.id)

      toggle = Task.find_by(id: task.id)

      expect(toggle.completion_date.strftime('%Y-%m-%d')).must_equal '2019-07-13'
    
    end
  end
end
