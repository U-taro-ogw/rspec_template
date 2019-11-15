class Book < ApplicationRecord
  has_many :comments

  validates :title, presence: true, length: { maximum: 100 }
  validates :author, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { only_integer: true }

  class << self
    def bulk_insert(books_param)
      before_ids = all.ids
      insert_all(books_param)
      where(id: (before_ids - all.ids))
    end
  end
end
