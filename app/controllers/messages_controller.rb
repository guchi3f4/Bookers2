class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to room_path(@message.room_id)
    else
      @room = Room.find(@message.room_id)
      @messages = @room.messages
      @anotherEntry = Entry.where(room_id: @room).where.not(user_id: current_user.id)
      render "rooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
