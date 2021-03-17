class LikesController < ApplicationController
  before_action :set_room
  before_action :authenticate_user!

  def create
    if @room.user_id != current_user.id
    @like = Like.create(user_id: current_user.id, room_id: @room.id)
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, room_id: @room.id)
    @like.destroy
  end

  private 
  def set_room
    @room = Room.find(params[:room_id])
  end
end
