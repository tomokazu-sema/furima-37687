FactoryBot.define do
  factory :order_address do
    token         { 'tok_abcdefghijk00000000000000000' }
    postal_code   { '123-4567' }
    prefecture_id { 14 }
    city          { '東京市' }
    addresses     { '東京1-1' }
    building      { '東京アパート' }
    phone_number  { '09012345678' }
  end
end
