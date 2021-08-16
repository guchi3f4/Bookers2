class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    GroupUser.create(group_id: @group.id, user_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find_by(group_id: @group.id, user_id: current_user.id).destroy
    redirect_to request.referer
  end

  private

end
