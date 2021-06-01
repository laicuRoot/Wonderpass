class StampbooksController < ApplicationController
  def index
    @user_stampbooks = Stampbook.where(user: current_user)
    # @stampbooks = Stampbook.where(status: true)
  end

  def show
  end
end
