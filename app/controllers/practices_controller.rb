class PracticesController < ApplicationController
  before_action :not_login_user, only: %i[index create]
  before_action :not_authenticate_user, only: [:index]
  before_action :set_practice, only: %i[show edit destroy update]
  before_action :self_practice, only: %i[show edit update destroy]
  before_action :new_separate, only: [:new]
  def index
    @practice = Practice.page(params[:page]).per(16).order(created_at: :desc)
  end

  def show
    @user = @practice.user
    @like = Like.new
    @comment = Comment.new
    @comments = Comment.where(song_id: params[:id])
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
    @message = AdviseChat.new
    @messages = AdviseChat.where(practice_id: params[:id])
  end

  def edit
  end

  def my_list
    @practices = Practice.where(user_id: params[:id])
    @user = User.find(params[:id])
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new(practice_params)
    @practice.user_id = current_user.id
    if @practice.save
      flash[:notice] = '投稿されました'
      redirect_to practice_path(@practice)
    else
      @error = @practice
      render new_practice_path
    end
  end

  def destroy
    @practice.destroy
    flash[:notice] = '投稿が削除されました'
    redirect_to songs_path
  end

  def update
    @practice.update(practice_params)
    flash[:notice] = '投稿を編集しました'
    redirect_to practice_path(@practice)
  end

  private

  def practice_params
    params.require(:practice).permit(:title, :description, :video)
  end

  def set_practice
    @practice = Practice.find(params[:id])
  end

  def self_practice
    @practice = Practice.find(params[:id])
    unless @practice.user == current_user || instructor_signed_in?
      if user_signed_in?
        redirect_to songs_path
      else
        redirect_to new_user_session_path
      end
    end
  end

  def  new_separate
    if user_signed_in?
      redirect_to songs_path if current_user.member_status == '一般会員'
    else
      redirect_to new_user_session_path
    end
  end
end
