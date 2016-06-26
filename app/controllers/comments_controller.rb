class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def create
    @recipe = Recipe.find(params[:recipe])
    @comment = current_user.comments.new(:recipe => @recipe, :text => params[:comment])

    respond_to do |format|
      if @comment.save
        format.js { render layout: false, content_type: 'text/javascript'}
      else
        format.json { render :json => @comment.errors, :status => 500}
      end
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
end
