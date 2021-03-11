require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録できるとき' do
      it "全項目入力で登録できる" do
        expect(@user).to be_valid
      end
    end
  end

  context '新規登録できないとき' do
    it 'nameが空では登録できない' do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できない' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが存在してもpassword_confirmitionが空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが5文字以下だと登録できない" do
      @user.password = "aaaa"
      @user.password_confirmation = "aaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      friend = FactoryBot.build(:user)
      friend.email = @user.email
      friend.valid?
      expect(friend.errors.full_messages).to include("Email has already been taken")
    end

    it "emailが＠を含まない場合登録できない" do
      @user.email = "testtest"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'sex_idが1では登録できない' do
      @user.sex_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("Sex must be other than 1")
    end

    it 'nameが14文字以上では登録できない' do
      @user.name = "あいうえおあいうえおあいうえお"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name is too long (maximum is 14 characters)")
    end

  end


end
