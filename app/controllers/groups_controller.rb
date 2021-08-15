class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group_user = GroupUser.create(group_id: @group.id, user_id: current_user.id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.group_users
  end

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
    if current_user.id != @group.owner_id
      redirect_to user_path(current_user)
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :owner_id).merge(owner_id: current_user.id)
  end
end
