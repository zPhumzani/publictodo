class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :change]
  before_action :set_task, only: [:edit, :update, :destroy, :change]

  # GET /tasks
  # GET /tasks.json
  def index
    if user_signed_in? && current_user
      @tasks_todo = current_user.tasks.where(state: 'to_do')
      @tasks_doing = current_user.tasks.where(state: 'doing')
      @tasks_done = current_user.tasks.where(state: 'done')
    else
      @tasks = Task.all.where(private: false)
      @tasks_todo = Task.where(state: 'to_do', private: false)
      @tasks_doing = Task.where(state: 'doing', private: false)
      @tasks_done = Task.where(state: 'done', private: false)
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.friendly.find(params[:id])
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
    @task = current_user.tasks.build(task_params)

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
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
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

  def change
    if params[:private]
      @task.update_attributes(private: params[:private])
    elsif params[:state]
      @task.update_attributes(state: params[:state])
    end
    redirect_to tasks_path, notice: 'Task Updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:content, :slug, :private, :state)
    end
end
