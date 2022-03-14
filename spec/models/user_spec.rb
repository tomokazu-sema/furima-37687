require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '登録条件を全て満たした場合は登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複している場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていない場合は登録できない' do
        @user.email = 'testsample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下の場合は登録できない' do
        @user.password = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英数字混合でない場合は登録できない' do
        tests = [Faker::Lorem.characters(number: 6, min_alpha: 6), Faker::Lorem.characters(number: 6, min_numeric: 6)]
        tests.each do |test|
          @user.password = test
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
        end
      end
      it 'passwordがpassword_confirmationと一致していない場合は登録できない' do
        @user.password_confirmation = Faker::Lorem.characters(number: 7, min_alpha: 1, min_numeric: 1)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが全角漢字・ひらがな・カタカナでない場合は登録できない' do
        tests = ['tarou', 'ﾀﾛｳ', '0000', '＄＄＄＄', 'ｔａｒｏｕ']
        tests.each do |test|
          @user.first_name = test
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
        end
      end
      it 'last_nameが全角漢字・ひらがな・カタカナでない場合は登録できない' do
        tests = ['yamada', 'ﾔﾏﾀﾞ', '0000', '＄＄＄＄', 'ｙａｍａｄａ']
        tests.each do |test|
          @user.last_name = test
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
        end
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが全角カタカナでない場合は登録できない' do
        tests = ['tarou', 'ﾀﾛｳ', '0000', '＄＄＄＄', 'ｔａｒｏｕ', '太郎', 'たろう']
        tests.each do |test|
          @user.first_name_kana = test
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
        end
      end
      it 'last_name_kanaが全角カタカナでない場合は登録できない' do
        tests = ['yamada', 'ﾔﾏﾀﾞ', '0000', '＄＄＄＄', 'ｙａｍａｄａ', '山田', 'やまだ']
        tests.each do |test|
          @user.last_name_kana = test
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
        end
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
