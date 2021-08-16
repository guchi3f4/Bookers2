class EventMessagesController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event_message = EventMessage.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event_message = EventMessage.new(event_message_params)
    @event_message.group_id = @group.id
    if @event_message.save
      redirect_to group_event_messages_path
      flash[:event_message] = "送信が完了しました"
    else
      render :new
    end
  end

  def index
    @group = Group.find(params[:group_id])
    if @group.group_users?(current_user)
      @event_messages = @group.event_messages
    else
      redirect_to group_path(@group)
    end
  end

  private

  def event_message_params
    params.require(:event_message).permit(:title, :content)
  end
end
