class TasksController < ApplicationController
    before_action :authenticate_user!
    def create
        @project = Project.find(params[:project_id])
        @task = Task.new task_params
        @task.project = @project
        if @task.save
            redirect_to project_path(@project)
        else
        @tasks = @project.tasks.order(created_at: :desc)
        render 'projects/show'
        end    
    end
    def destroy
        @project = Project.find(params[:project_id])
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to project_path(@project), notice: 'Project Deleted'
    end
    
    private

    def task_params
        params.require(:task).permit(:body, :done)
    end
end
