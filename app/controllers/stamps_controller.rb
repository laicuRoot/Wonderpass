class StampsController < ApplicationController
  before_action :set_stamp, only: [:show]

  def index
    @stampbook = Stampbook.find(params[:stampbook_id])
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_stamp
    @stamp = Stamp.find(params[:id])
  end
end
