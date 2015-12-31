class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :executors, :executor, :update]

  # GET /tasks
  # GET /tasks.json
  def index
    authorize! :read_list, Task
    @tasks = Task.with_options params, current_user
  end

  # GET /tasks/executors
  # GET /tasks/executors.js
  def executors
    authorize! :create, Task
    @users = User.search(executors_params[:search]).page(executors_params[:page])
    @tasks_counts = User.all_users_tasks_counts
  end

  # GET /tasks/executor/1
  # GET /tasks/executor/1.js
  def executor
    authorize! :create, Task
    @user = User.find(params[:user_id])
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new(task_params)
    if request.xhr?
      #render js: "alert '#{new_task_path(task: {executor: current_user.id})}';"
      render js: "window.location = '#{new_task_path(task: {user_id: current_user.id})}'"
    else
      unless @task.executor
        redirect_to tasks_executors_path
      else
        render
      end
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.outcoming_tasks.new(task_params)
    @task.attachments_attributes = attachments_params if attachments_params

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: t('Task was successfully created.') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if task_params.present?
      authorize! :update, @task
      @task.assign_attributes(task_params)
      @task.attachments_attributes = attachments_params if attachments_params
    end
    if event_params.present?
      authorize! :change_states, @task
      @task.perform_event event_params[:event], current_user
    end
    respond_to do |format|
      if @task.save
        #format.html { true_redirect_or_render }
        format.html { redirect_to_back_or @task, notice: t('Task was successfully updated.') }
        format.json { render :show, status: :ok, location: @task }
      else
        #format.html { true_redirect_or_render }
        format.html {
          if @task.errors.messages[:event]
            redirect_to :back, alert: @task.errors.full_messages.join(', ')
          else
            render :edit
          end
        }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachments_params
      #params.permit(attachments: [:tempfile, :original_filename, :content_type, :headers, :stuff])[:attachments] || {}
      params.permit(attachments: [:tempfile, :original_filename, :content_type, :headers, :stuff])[:attachments] || {}
    end
    def executors_params
      params.permit(:search, :sort, :page)
    end
    def event_params
      params.permit(:event)
    end
    def task_params
      #params.require(:task).permit(:description, :name, :user_id).permit(:event)
      params.permit(task: [:description, :name, :user_id, attachment_ids: []])[:task] || {}

    end
end
