class StampsController < ApplicationController
  def index
    @stampbook = Stampbook.find(params[:stampbook_id])
    @indexing = 0
    @limit = 6
  end

  def show
  end

  def edit
  end

  def update
  end
end
