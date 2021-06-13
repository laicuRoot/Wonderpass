class InvitationsController < ApplicationController

  def new;end

  def create
    @user = User.find(params[:user_id])
    @invitation = Invitation.new
    @invitation.user_id = @user.id
    @invitation.friend_id = current_user.id
    if @invitation.save
      # raise
      redirect_to user_path(@user)
    else
      flash.alert = "Unable to add to send invitation"
    end
  end

  def edit;end

  def update;end


end
