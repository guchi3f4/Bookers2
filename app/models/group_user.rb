class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :event_message
end

