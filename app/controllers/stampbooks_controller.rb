class StampbooksController < ApplicationController
  before_action :find_user

  def index
    @user_stampbooks = Stampbook.where(user_id: @user.id)
    # @stampbooks = Stampbook.where(status: true)
  end

  def show;
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
