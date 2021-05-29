class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @stamp_count = @user.stamps.where(stamp_status: true).count
  end
end
