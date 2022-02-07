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
    redirect_to new_location_url
  rescue ValidationError
    render :new
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

  def destroy
    @stampbook = Stampbook.find(params[:id])
    @user = @stampbook.user
    @stampbook.destroy

    redirect_to user_stampbooks_path(@user)
  end

  private

  def new_location_url
    new_stampbook_location_path(find_stampbook(stampbook_name))
  end

  def find_stampbook(stampbook_name)
    Stampbook.all.find_by(stampbook_name: stampbook_name)
  end

  def find_user
    @user = User.find(user_id)
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

  def stampbook_params
    params.require(:stampbook).permit(:stampbook_name, :stampbook_description, :status, :location_name, :location_ids)
  end
end
