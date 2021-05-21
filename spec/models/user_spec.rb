require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規ユーザー登録' do

    it '全ての項目が問題なく埋まっている' do
      expect(@user).to be_valid
    end

    it 'ニックネームが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールが既に存在している場合は登録できない' do
      @user.save
      @user2 = FactoryBot.build(:user)
      @user2.email = @user.email
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'メールに@がないと登録ができない' do
      @user.email = 'tamago'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'パスワードが６文字以上、半角英数混合で登録ができる' do
      @user.password = 'tama00'
      @user.password_confirmation = 'tama00'
      expect(@user).to be_valid
    end

    it 'パスワードが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが5文字以下では登録できない' do
      @user.password = 'aaa00'
      @user.password_confirmation = 'aaa00'
      @user.valid?
      expect(@user.errors.full_messages).to include( "Password is too short (minimum is 6 characters)")
    end

    it 'パスワードが半角英語のみでは登録できない' do
      @user.password = 'tamago'
      @user.password_confirmation = 'tamago'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'パスワードが半角数字のみでは登録できない' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'パスワードが全角英数では登録できない' do
      @user.password = '００００００'
      @user.password_confirmation = '００００００'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'パスワードと確認が一致しないと登録できない' do
      @user.password = 'tama00'
      @user.password_confirmation = 'tama11'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '本人確認' do

    it 'last_nameが全角であれば登録できる' do
      @user.last_name = '田中'
      expect(@user).to be_valid
    end

    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが半角では登録できない' do
      @user.last_name = 'tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end

    it 'family_nameが全角であれば登録できる' do
      @user.family_name = '正造'
      expect(@user).to be_valid
    end

    it 'family_nameが空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end

    it 'family_nameが半角では登録できない' do
      @user.family_name = 'syouzo'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid")
    end

    it 'kana_last_nameが全角カタカナであれば登録できる' do
      @user.kana_last_name = 'タナカ'
      expect(@user).to be_valid
    end

    it 'kana_last_nameが空では登録できない' do
      @user.kana_last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana last name can't be blank")
    end

    it 'kana_last_nameが全角カタカナ意外では登録できない' do
      @user.kana_last_name = '田中'
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana last name is invalid")
    end

    it 'kana_family_nameが全角カタカナであれば登録できる' do
      @user.kana_family_name = 'ショウゾウ'
      expect(@user).to be_valid
    end

    it 'kana_family_nameが空では登録できない' do
      @user.kana_family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana family name can't be blank")
    end

    it 'kana_family_nameが全角カタカナ意外では登録できない' do
      @user.kana_family_name = '正造'
      @user.valid?
      expect(@user.errors.full_messages).to include("Kana family name is invalid")
    end

    it 'birth_dayが空では登録できない' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end
