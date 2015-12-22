class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_authorize_resource :only => :index  

  # GET /tasks
  # GET /tasks.json
  def index
    authorize! :read_list, Task
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
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
    @task.assign_attributes(task_params)
    @task.perform_event event_params[:event], current_user
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
    def event_params
      #params.require(:task).permit(:description, :name, :user_id).permit(:event)
      params.permit(:event)
    end
    def task_params
      #params.require(:task).permit(:description, :name, :user_id).permit(:event)
      params.permit(task: [:description, :name, :user_id])[:task] || {}

    end
end
