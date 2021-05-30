class StampsController < ApplicationController
  before_action :find_stamp, only: [:show, :edit, :update]
  before_action :find_stampbook, only: [:edit, :update]

  def show
  end

  def edit; end

  def update
    @stamp.update(stamp_params)
    redirect_to stampbook_stamp_path(@stamp)
  end

  private

  def stamp_params
    params.require(:stamp).permit(:stamp_status)
  end

  def find_stamp
    @stamp = Stamp.find(params[:id])
  end

  def find_stampbook
    @stampbook = Stampbook.find(params[:stampbook_id])
  end

end
