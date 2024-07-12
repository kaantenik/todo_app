class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /tasks or /tasks.json
  def index
    @task = Task.new
    @tasks = current_user.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    authorize @task
  end

  # GET /tasks/new
  def new
    @task = Task.new
    authorize @task
  end

  # GET /tasks/1/edit
  def edit
    authorize @task
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    authorize @task
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    authorize @task
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end
end
