class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :event_messages, dependent: :destroy
    attachment :image

    validates:name,
      presence: true,
      length: { in: 2..20 }
    validates:introduction,
      length: { maximum: 50 }

    def group_users?(user)
      group_users.where(user_id: user).exists?
    end
end
