class User < ApplicationRecord
  has_one :user_profile

  validates :name, length: { in: 1..10 }
end
