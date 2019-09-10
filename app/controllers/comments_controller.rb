class CommentsController < ApplicationController
    before_action :find_project
    before_action :find_discussion
    before_action :finde_comment, only: [:show, :edit, :update, :destroy]
    def create
        @comment = Comment.new comment_params
        @comment.discussion = @discussion
        if @comment.save
            redirect_to project_discussion_path(@project,@discussion)
        else
        @comments = @discussion.comments.order(created_at: :desc)
        render 'discussions/show'
        end    
    end
    def edit
        
    end
    def show
        @comments = @discussion.comments.order(created_at: :desc)
        render 'discussions/show'
    end
    def update
        if @comment.update comment_params
            redirect_to project_discussion_path(@project,@discussion), notice: 'Comment Updated'
        else
          render :edit
        end
    end

    def destroy
        @comment.destroy
        redirect_to project_discussion_path(@project,@discussion), notice: 'Comment Deleted'
    end

    private 

    def comment_params
        params.require(:comment).permit(:body)
    end

    def find_project
        @project = Project.find(params[:project_id])
    end

    def find_discussion
        @discussion = Discussion.find(params[:discussion_id])
    end

    def finde_comment
        @comment = Comment.find(params[:id])
    end
end
