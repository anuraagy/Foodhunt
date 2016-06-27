class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def show
    @user = User.find(params[:id])
  end

  def edit_job
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript'}
    end
  end

  def update_job
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(:job => params[:job])
        format.js { render layout: false, content_type: 'text/javascript'}
      else
        format.json { render :json => @user.errors, :status => 500}
      end
    end
  end

  def edit_name
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript'}
    end
  end

  def update_name
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(:name => params[:name])
        format.js { render layout: false, content_type: 'text/javascript'}
      else
        format.json { render :json => @user.errors, :status => 500}
      end
    end
  end

end
