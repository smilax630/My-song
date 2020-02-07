class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i{edit}
  before_action :set_user, only: %i{show edit update}


  def index
  end

  def show
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報が更新されました"
      redirect_to user_path(@user)
    else
      @error = @user
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :description, :profile_image)
  end
end
