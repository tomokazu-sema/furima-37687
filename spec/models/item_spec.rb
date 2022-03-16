require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it '出品条件を全て満たした場合は出品できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'infoが空では出品できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'category_idが初期値では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'sales_status_idが初期値では出品できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it 'shipping_fee_status_idが初期値では出品できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it 'prefecture_idが初期値では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'scheduled_delivery_idが初期値では出品できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      it 'priceが空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300~9999999以外では出品できない' do
        tests = [299, 10_000_000, Faker::Number.within(range: 0..298), Faker::Number.within(range: 10_000_001..99_999_999)]
        tests.each do |test|
          @item.price = test
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is out of setting range')
        end
      end
      it 'priceが半角数値以外では出品できない' do
        tests = ['３０００', '3,000', '¥3000', '￥３０００', 'threethousand', '三千', 'さんぜん', 'サンゼン', 'ｻﾝｾﾞﾝ']
        tests.each do |test|
          @item.price = test
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
        end
      end
    end
  end
end
