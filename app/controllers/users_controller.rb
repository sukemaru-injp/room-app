class UsersController < ApplicationController
  before_action :no_room_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @room = @user.room
  end

  private
  def no_room_user
    @user = User.find(params[:id])
    unless Room.exists?(user_id: @user.id)
      redirect_to new_room_path
    end
  end

end
