class StampbooksController < ApplicationController
  before_action :find_user, except: [:clone]

  def index
    @user = User.find(params[:user_id])
    @user_stampbooks = Stampbook.where(user_id: @user.id)
    # @stampbooks = Stampbook.where(status: true)
  end

  def show
  end

  def new
    @stampbook = Stampbook.new
    @locations = Location.all
  end

  def create
    @stampbook = Stampbook.new(stampbook_params)
    @stampbook.user = current_user
    @location_ids = params[:stampbook][:location_ids]
    if @stampbook.save
      @location_ids.each do |location_id|
        Stamp.create(location_id: location_id, stampbook_id: @stampbook.id, stamp_status: false)
      end
      redirect_to user_stampbooks_path(current_user)
    else
      render :new
    end
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

  private

  def stampbook_params
    params.require(:stampbook).permit(:stampbook_name, :stampbook_description, :status, :location_name, :location_ids)
  end
end
