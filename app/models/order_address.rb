class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)'}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' }
  end
  validates :phone_number, format:{ with: /\A[0-9]{10,11}\z/, message: 'is too short' }
end