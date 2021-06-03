class StampsController < ApplicationController
before_action :set_stamp, only: [:show]

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
