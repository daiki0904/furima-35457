require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    def error_mess(error_message)
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include(error_message)
    end

    context '商品購入ができる場合' do
      it '全ての値が正しく入力されている' do
        expect(@order_address).to be_valid
      end

      it '建物名がなくても商品は購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it 'tokenが存在しない' do
        @order_address.token = ''
        error_mess("Token can't be blank")
      end

      it '郵便番号がない' do
        @order_address.postal_code = ''
        error_mess("Postal code can't be blank")
      end

      it '郵便番号の最初が３桁じゃない' do
        @order_address.postal_code = '12-4567'
        error_mess("Postal code is invalid")
      end

      it '郵便番号の後半が４桁じゃない' do
        @order_address.postal_code = '123-567'
        error_mess("Postal code is invalid")
      end

      it '郵便番号にハイフンが存在しない' do
        @order_address.postal_code = '1234567'
        error_mess("Postal code is invalid")
      end

      it '都道府県が選択されていない' do
        @order_address.prefecture_id = 1
        error_mess('Prefecture must be other than 1')
      end

      it '市区町村が記入されていない' do
        @order_address.city = ''
        error_mess("City can't be blank")
      end

      it '番地が存在しない' do
        @order_address.house_number = ''
        error_mess("House number can't be blank")
      end

      it '電話番号がない' do
        @order_address.phone = ''
        error_mess("Phone can't be blank")
      end

      it '電話番号が10桁ない' do
        @order_address.phone = '080111222'
        error_mess("Phone is invalid")
      end

      it '電話番号が12桁以上ある' do
        @order_address.phone = '080111122223'
        error_mess("Phone is invalid")
      end

      it '電話番号に文字列が含まれている' do
        @order_address.phone = '080-1111-2222'
        error_mess("Phone is invalid")
      end

      it '電話番号が半角数値じゃない' do
        @order_address.phone = '０８０１１１１２２２２'
        error_mess("Phone is invalid")
      end

      it 'user_idが存在しない' do
        @order_address.user_id = ''
        error_mess("User can't be blank")
      end

      it 'item_idが存在しない' do
        @order_address.item_id = ''
        error_mess("Item can't be blank")
      end
    end
  end
end
