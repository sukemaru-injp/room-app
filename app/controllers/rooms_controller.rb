class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :user_has_room, only: [:new, :create]
  before_action :set_room, only: [:edit, :update, :show]
  before_action :no_current_user, only: [:edit, :update]

  def index
    @rooms = Room.includes(:user).limit(8).order(id: "DESC")
  end

  def new
    @room = RoomsTag.new
  end

  def create
    @room = RoomsTag.new(room_params)
    tag_list = params[:room][:name].split(",")
    if @room.valid?
      @room.save(tag_list)
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @form = RoomsTag.new(room: @room)
  end

  def update
    @form = RoomsTag.new(room_params, room: @room)
    tag_list = params[:room][:name].split(",")
    if @form.valid?
      @form.save(tag_list)
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def show
  end


  private
  def room_params
    params.require(:room).permit(:image, :title, :content, :place_id, :floor_id, :style_id, :name).merge(user_id: current_user.id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def user_has_room
    if Room.exists?(current_user.id)
      flash[:notice] = 'すでにお部屋があります'
      redirect_to root_path
    end
  end

  def no_current_user
    @room = Room.find(params[:id])
    if current_user.id != @room.user_id
      redirect_to root_path
    end
  end

end
