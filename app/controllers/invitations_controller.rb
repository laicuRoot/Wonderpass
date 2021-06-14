class InvitationsController < ApplicationController

  def new;end

  def create
    @user = User.find(params[:user_id])
    @invitation = Invitation.new
    @invitation.user_id = current_user.id
    @invitation.friend_id = @user.id
    if @invitation.save
      # raise
      flash.alert = "The invitation has been sent"
      redirect_to user_path(@user)
    else
      flash.alert = "Unable to add to send invitation"
    end
  end

  def edit;end

  def update
    # @user = User.find(params[:user_id])
    @invitation = Invitation.find(params[:id])
    @invitation.update(invitation_params)
    redirect_to user_path(current_user)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:confirmed)
  end
end
