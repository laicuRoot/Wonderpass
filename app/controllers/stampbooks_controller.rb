class StampbooksController < ApplicationController
  before_action :find_user, except: [:clone]

  def index
    @user_stampbooks = Stampbook.where(user_id: @user.id)
    # @stampbooks = Stampbook.where(status: true)
  end

  def show;
  end

  def clone
    @stampbook = Stampbook.find(params[:id])
    @newbook = @stampbook.dup
    @newbook.user = current_user
    if @newbook.save
      Stampbook.create_stamps(@stampbook, @newbook)
      redirect_to stampbook_stamps_path(@newbook);
      flash[:notice] = "Stampbook #{@newbook.stampbook_name} has been cloned"
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
