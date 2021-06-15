class StampbooksController < ApplicationController
  before_action :find_user

  def index
    @user_stampbooks = Stampbook.where(user_id: @user.id)
    # @stampbooks = Stampbook.where(status: true)
  end

  def show
  end

  def new
    @stampbook = Stampbook.new
  end

  def create
    @stampbook = Stampbook.new(stampbook_params)
    @stampbook.user = @user
    if @itinerary.save
      redirect_to user_stampbooks_path(@user)
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def stampbook_params
    params.require(:stampbook).permit(:stampbook_name, :stampbook_description, :status)
  end
end
