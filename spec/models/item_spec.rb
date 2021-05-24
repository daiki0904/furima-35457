require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  def error_mess(error_message)
    @item.valid?
    expect(@item.errors.full_messages).to include(error_message)
  end
  
  describe '商品出品機能' do
    context '出品できる場合' do
      it '全ての情報が入力されている' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '写真が空になっている' do
        @item.image = nil
        error_mess("Image can't be blank")
      end

      it '商品名が空になっている' do
        @item.item_name = ''
        error_mess("Item name can't be blank")
      end

      it '説明が空になっている' do
        @item.information = '' 
        error_mess("Information can't be blank")
      end

      it 'カテゴリーが選択されていない' do
        @item.category_id = 1
        error_mess("Category must be other than 1")
      end

      it '商品の状態が選択されていない' do
        @item.status_id = 1
        error_mess("Status must be other than 1")
      end

      it '配送料の負担が選択されていない' do
        @item.shipping_fee_id = 1
        error_mess("Shipping fee must be other than 1")
      end

      it '発送元の地域指定ができていない' do
        @item.prefecture_id = 1
        error_mess("Prefecture must be other than 1")
      end

      it '発送までのに数が指定されていない' do
        @item.schedule_id = 1
        error_mess("Schedule must be other than 1")
      end

      it '商品価格が入力されていない' do
        @item.price = ''
        error_mess("Price can't be blank")
      end

      it '商品価格が全角で入力されている' do
        @item.price = '６０００'
        error_mess("Price is not a number")
      end

      it '商品価格が300以下' do
        @item.price = 299
        error_mess("Price must be greater than or equal to 300")
      end

      it '商品の価格が10000000以上' do
        @item.price = 10000000
        error_mess("Price must be less than or equal to 9999999")
      end

      it '商品価格に数字以外が入力されている' do
        @item.price = 'こんにちは'
        error_mess("Price is not a number")
      end

      it '商品価格に半角英語が入っている' do
        @item.price = 'aaaaa00'
        error_mess("Price is not a number")
      end
    end
  end
end
