class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  has_one_attached :image
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :sales_status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
    validates :price, 
              numericality: { in: 300..9999999 },
              format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }
  end
end
