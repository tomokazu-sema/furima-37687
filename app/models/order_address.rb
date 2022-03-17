class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id
end