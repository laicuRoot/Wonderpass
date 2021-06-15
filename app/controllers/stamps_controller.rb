class StampsController < ApplicationController
  before_action :find_stamp, only: [:show, :edit, :update]
  before_action :find_stampbook, only: [:index, :edit, :update]
  before_action :calc_percent, only: [:edit, :index, :update]
  before_action :count_badges, only: :index
  after_action :create_badge, only: :update

  def index
    @stamps = @stampbook.stamps.order(:id)
    @index = 1
    @page_number = 0
    @total = @stampbook.count_stamps
    @count = @stampbook.stampbook_pages
    @count += 1 unless @count.even?
    @collected = @stampbook.collected_stamps.size
    @percent = @stampbook.percent_completed
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

  def count_badges
    @badges = @stampbook.badges.order(created_at: :desc)
    @badge_total = Badge.count - @badges.size
  end

  def create_badge
    get_badges
    @achievement = Achievement.where(stampbook: @stampbook)
    gold = Achievement.new(stampbook: @stampbook, badge: @gold)
    gold.save! unless @percent < 90 || @achievement.where(badge: @gold).present?
    silver = Achievement.new(stampbook: @stampbook, badge: @silver) 
    silver.save! unless @percent < 50 || @achievement.where(badge: @silver).present?
    bronze = Achievement.new(stampbook: @stampbook, badge: @bronze)
    bronze.save! unless @percent < 25 || @achievement.where(badge: @bronze).present?
  end

  def get_badges
    @gold = Badge.find_by(name: "Gold")
    @silver = Badge.find_by(name: "Silver")
    @bronze = Badge.find_by(name: "Bronze")
  end

  def calc_percent
    @stamps = @stampbook.stamps.order(:id)
    @collected = @stamps.where(stamp_status: true).size
    @total = @stamps.size
    @percent = (@collected.fdiv(@total) * 100).floor
  end
end
