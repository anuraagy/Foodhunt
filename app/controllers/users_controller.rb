class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def edit_job
    current_user.job = params[:job]

    if current_user.save
      head :ok
    else
      render :json => { :success => false }
    end
  end

  private

  def user_params
    params.require(:recipe).permit(:job, :username)
  end

end
