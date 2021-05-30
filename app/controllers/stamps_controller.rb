class StampsController < ApplicationController
  def index
    @stampbook = Stampbook.find(params[:stampbook_id])
  end

  def show
  end

  def edit
  end

  def update
  end
end
