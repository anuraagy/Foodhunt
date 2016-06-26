class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to @comment
    else
      render :new
    end
  end

  def update
    @comment = comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit
    end
  end

  def destroy
    @comment = comment.find(params[:id])
    @comment.destroy

    render :back
  end

  private

  def comment_params
    params.require(:comment).permit(:recipe, :user, :text)
  end
end
