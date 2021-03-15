class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @room = @user.room
  end
end
