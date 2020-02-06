class SongsController < ApplicationController
  before_action :authenticate_user!, only: %i{edit new}
  
  def index
    @song = Song.all.order(created_at: :desc)
  end

  def show
    @song = Song.find(params[:id])
    @user = @song.user
    @songs = Song.where(user_id: @user.id).limit(5).where.not(id: @song.id)
    @like = Like.new
    @new_comment = Comment.new
    @comments = Comment.where(song_id: params[:id])
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to song_path(@song)
    else
      @error = @song
      render 'edit'
    end
  end

  def my_list
    @song = Song.where(user_id: params[:id])
    @user = User.find(params[:id])
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
  end

  def new
    @song = Song.new
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "投稿が削除されました"
    redirect_to songs_path
  end

  def create
    @song = Song.new(song_params)
    @song.user_id = current_user.id
    if @song.save
      flash[:notice] = "投稿されました"
      redirect_to song_path(@song)
    else
      @error = @song
      render new_song_path
    end
  end

  def rank
    @all_ranks = Song.find(Like.group(:song_id).order('count(song_id) desc').limit(10).pluck(:song_id))
  end

  private

  def song_params
    params.require(:song).permit(:title, :description, :thumbnail, :voice)
  end
end
