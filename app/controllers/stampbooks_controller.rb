class StampbooksController < ApplicationController
  before_action :find_user, only: :index

  def index
    @user_stampbooks = Stampbook.where(user_id: @user.id)
  end

  def show; end

  def new
    @stampbook = Stampbook.new
    @locations = Location.order(:created_at).includes(:location_name).limit(10)
  end

  def create
    stampbook = CreateStampbook::StampbookCreator.call(params: stampbook_params, user: current_user, location_ids: location_ids)
    redirect_to new_stampbook_location_path(stampbook)
  rescue ActiveRecord::RecordInvalid
    redirect_to new_stampbook_path
  end

  def clone
    CreateStampbook::StampbookDuplicator.call(stampbook_id: params[:id], user: current_user)
    user = current_user
    redirect_to user_stampbooks_path(user);

  end

  def destroy
    stampbook = find_stampbook_by_id(params[:id])
    user = stampbook.user
    stampbook.destroy

    redirect_to user_stampbooks_path(user)
  end

  private

  def find_stampbook_by_id(stampbook_id)
    Stampbook.find(stampbook_id)
  end

  def stampbook_name
    params[:stampbook][:stampbook_name]
  end

  def location_ids
    params[:stampbook][:location_ids]
  end

  def user_id
    params[:user_id]
  end

  def find_user
    @user = User.find(user_id)
  end

  def stampbook_params
    params.require(:stampbook).permit(:stampbook_name, :stampbook_description, :status, :location_name, :location_ids)
  end
end
