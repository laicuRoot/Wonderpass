class StampsController < ApplicationController
  before_action :find_stamp, only: [:show, :edit, :update]
  before_action :find_stampbook, only: [:edit, :update]
  after_action :create_badge, only: :update
  def index
    @stampbook = Stampbook.find(params[:stampbook_id])
    @stamps = @stampbook.stamps.order(:id)
    @index = 1
    @page_number = 0
    @count = @stampbook.stamps.count.fdiv(6).ceil
    @count += 1 unless @count.even?
    @collected = @stamps.where(stamp_status: true).size
    @total = @stamps.size
    @percent = @collected.fdiv(@total) * 100
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        @stamp.stamp_status = true
        format.html { redirect_to stampbook_stamps_path(@stampbook), notice: 'Stamp was successfully collected!' }
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

  def create_badge
    calc_percent
    get_badges
    if @percent > 90
      Achievement.create(stampbook: @stampbook, badge: @gold) unless @achievement.where(badge: @gold)
    elsif @percent > 50
      Achievement.create(stampbook: @stampbook, badge: @silver) unless @achievement.where(badge: @silver)
    elsif @percent > 25
      Achievement.create(stampbook: @stampbook, badge: @bronze) unless @achievement.where(badge: @bronze)
    end
    raise
  end

  def calc_percent
    @stamps = Stamp.where(stampbook: @stampbook)
    @completed = @stamps.where(stamp_status: true)
    @percent = @completed.size.fdiv(@stamps.size)*100
    @achievement = Achievement.where(stampbook: @stampbook)
  end

  def get_badges
    @gold = Badge.find_by(name: "Gold")
    @silver = Badge.find_by(name: "Silver")
    @bronze = Badge.find_by(name: "Bronze")
  end
end
