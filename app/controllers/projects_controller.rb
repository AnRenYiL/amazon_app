class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  def new
    @project = Project.new
    render :new
  end
  def create
    @project = Project.new project_params
    if @project.save
      flash[:notice] = "Project created successfully"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @task  = Task.new
    @discussion = Discussion.new
    @tasks = @project.tasks.order(created_at: :desc)
    @discussions = @project.discussions.order(created_at: :desc)
  end

  def index
    @projects = Project.all
  end
  def edit
    
  end
  
  def update
    if @project.update project_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Project destroyed!"
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :auther, :deadline)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
