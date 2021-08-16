class EventMessage < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :group
end