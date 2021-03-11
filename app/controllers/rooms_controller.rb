class RoomsController < ApplicationController

  def index
    
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
end
