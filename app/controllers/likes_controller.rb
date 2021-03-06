class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @song = Song.find(params[:song_id])
    @like = Like.create(song_id: params[:song_id], user_id: current_user.id)
  end

  def destroy
    @song = Song.find(params[:song_id])
    @like = Like.find_by(song_id: params[:song_id], user_id: current_user.id)
    @like.destroy
  end

  def my_list
    @user = User.find(params[:id])
    @song = @user.liked_songs
    @relation = Relationship.find_by(user_id: current_user, follow_id: @user.id)
    @new_follow = Relationship.new
  end
end
