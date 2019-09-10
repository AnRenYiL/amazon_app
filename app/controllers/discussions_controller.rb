class DiscussionsController < ApplicationController
    before_action :find_project, only: [:new, :create, :show, :edit, :update, :destroy]
    before_action :find_discussion, only: [:show, :edit, :update, :destroy]
    def new
        @discussion = Discussion.new
        render :new
    end
    def create
        @discussion = Discussion.new discussion_params
        @discussion.project = @project
        if @discussion.save
            redirect_to project_path(@project)
        else
        @discussions = @project.discussions.order(created_at: :desc)
        render 'projects/show'
        end    
    end
    def edit
    
    end
    def show
      if params[:id]&&params[:discussion_id]
        @comment = Comment.find(params[:id])
      else
        @comment = Comment.new
      end
      @comments = @discussion.comments.order(created_at: :desc)

    end
    def update
      if @discussion.update discussion_params
        redirect_to project_path(@project), notice: 'Discussion Updated'
      else
        render :edit
      end
    end
    def destroy
        @discussion.destroy
        redirect_to project_path(@project), notice: 'Discussion Deleted'
    end
    
    private

    def discussion_params
        params.require(:discussion).permit(:title, :body)
    end

    def find_project
        @project = Project.find(params[:project_id])
    end

    def find_discussion
        @discussion = Discussion.find(params[:id])
    end
end
