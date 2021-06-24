class InvitationsController < ApplicationController
  before_action :find_invitation, only: [:edit, :destroy, :update]

  def new;end

  def create
    @user = User.find(params[:user_id])
    @invitation = Invitation.new
    @invitation.user_id = current_user.id
    @invitation.friend_id = @user.id
    if @invitation.save
      # raise
      flash.alert = "The invitation has been sent"
      redirect_to user_path(current_user)
    else
      flash.alert = "Unable to add to send invitation"
    end
  end

  def edit;end

  def update
    @invitation.confirmed = true
    @invitation.save!
    redirect_to user_path(current_user)
  end

  def destroy
    @invitation.destroy
    redirect_to user_path(current_user)
  end

  private

  def find_invitation
    @invitation = Invitation.find(params[:id])
  end
end
