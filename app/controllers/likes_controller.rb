class LikesController < ApplicationController
  before_action :set_room

  def create
    if @room.user_id != current_user.id
    @likes = Like.create(user_id: current_user.id, room_id: @room.id)
    redirect_to root_path
    end
  end

  def destroy

  end

  private 
  def set_room
    @room = Room.find(params[:room_id])
  end
end
