class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price, 
              numericality: { in: 300..9999999 },
              format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }
  end
end
