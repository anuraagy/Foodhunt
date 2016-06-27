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

  def edit
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript'}
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update(:text => params[:comment])
        format.js { render layout: false, content_type: 'text/javascript'}
      else
        format.json { render :json => @comment.errors, :status => 500}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript'}
    end
  end

end
