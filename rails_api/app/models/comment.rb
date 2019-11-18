class Comment < ApplicationRecord
  belongs_to :book

  validates :text, presence: true,
                   length: { maximum: 100 }
end
