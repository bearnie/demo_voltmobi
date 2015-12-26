require 'rails_helper'

RSpec.describe Task, type: :model do

  before do
    @executor = FactoryGirl.create :user
    @task = FactoryGirl.create :task
  end

  it 'has "new" state after initialize' do
    expect(@task.state).to eq("new") 
  end

  it 'states may be changed as new => started => finished' do
    expect(@task.state).to eq("new") 
    @task.start
    expect(@task.state).to eq("started") 
    @task.finish
    expect(@task.state).to eq("finished") 
  end

  it 'cannot finish after new' do
    expect(@task.state).to eq("new") 
    @task.finish
    expect(@task.state).to eq("new") 
  end

  it 'cannot to start after finish' do
    @task.start
    expect(@task.state).to eq("started") 
    @task.finish
    expect(@task.state).to eq("finished") 
    @task.start
    expect(@task.state).to eq("finished") 
  end

  describe "function perform_event " do
    it 'may to run events new => start => finish' do
      expect(@task.state).to eq("new") 
      @task.perform_event :start, @user
      expect(@task.state).to eq("started") 
      @task.perform_event :finish, @user
      expect(@task.state).to eq("finished") 
    end

    it 'cannot finish after new, and add errors' do
      expect(@task.state).to eq("new") 
      @task.perform_event :finish, @user
      expect(@task.state).to eq("new") 
      expect(@task.errors.messages.count).to eq(1) 
    end

    it 'cannot to start after finish, and add errors' do
      @task.perform_event :start, @user
      expect(@task.state).to eq("started") 
      @task.perform_event :finish, @user
      expect(@task.state).to eq("finished") 
      @task.perform_event :start, @user
      expect(@task.state).to eq("finished") 
      expect(@task.errors.messages.count).to eq(1) 
    end

    it 'accepts string as param too' do
      expect(@task.state).to eq("new") 
      @task.perform_event "start", @user
      expect(@task.state).to eq("started") 
      @task.perform_event "finish", @user
      expect(@task.state).to eq("finished") 
    end

    it 'add error if events havent event from params' do
      @task.perform_event :unknown_event, @user
      expect(@task.state).to eq("new") 
      expect(@task.errors.messages.count).to eq(1) 
    end

  end

end
