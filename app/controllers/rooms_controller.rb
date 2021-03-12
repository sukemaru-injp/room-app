class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :user_has_room, only: [:new, :create]

  def index
    @rooms = Room.includes(:user).limit(8).order(id: "DESC")
  end

  def new
    @room = RoomsTag.new
  end

  def create
    @room = RoomsTag.new(room_params)
    if @room.valid?
      @room.save
      redirect_to root_path
    else
      render "new"
    end

  end


  private
  def room_params
    params.require(:rooms_tag).permit(:image, :title, :content, :place_id, :floor_id, :style_id, :name).merge(user_id: current_user.id)
  end

  def user_has_room
    if Room.exists?(current_user.id)
      flash[:notice] = 'すでにお部屋があります'
      redirect_to root_path
    end
  end

end
