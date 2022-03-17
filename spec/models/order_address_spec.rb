require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: item.user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品購入できる場合' do
      it '購入条件を全て満たした場合は購入できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingは無くても購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品購入できない場合' do
      it 'tokenが空では購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが3桁ハイフン4桁でないと購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが初期値では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空では購入できない' do
        @order_address.addresses = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値でないと購入できない' do
        tests = %w[０９０１２３４５６７８ 090-1234-5678]
        tests.each do |test|
          @order_address.phone_number = test
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
        end
      end
      it 'phone_numberが9桁以下では購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが12桁以上では購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long')
      end
      it 'userが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
