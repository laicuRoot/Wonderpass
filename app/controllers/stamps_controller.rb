
class StampsController < ApplicationController
  before_action :find_stamp, only: [:show, :edit, :update]
  before_action :find_stampbook, only: [:edit, :update]

  def index
    @stampbook = Stampbook.find(params[:stampbook_id])
    @indexing = 0
    @limit = 6
    if (@stampbook.stamps.count / 6).ceil.even?
      @ensure_even_pages = 0
    else
      @ensure_even_pages = 1
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        @stamp.stamp_status = true
        format.html { redirect_to stampbook_stamp_path(@stampbook, @stamp), notice: 'Stamp was successfully collected!' }
        format.json { render :show, status: :ok, location: @stamp }
      else
        format.html { render :edit, notice: 'Your stamp cannot be collected. Try again.' }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def stamp_params
    params.require(:stamp).permit(:stamp_status, :user_stamp_photo)
  end

  def find_stamp
    @stamp = Stamp.find(params[:id])
  end

  def find_stampbook
    @stampbook = Stampbook.find(params[:stampbook_id])
  end

end
