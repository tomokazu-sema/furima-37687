class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
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
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  end 
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is out of setting range' }
  with_options presence: true, numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
