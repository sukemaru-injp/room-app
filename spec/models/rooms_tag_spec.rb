require 'rails_helper'

RSpec.describe RoomsTag, type: :model do
  before do
    user = FactoryBot.create(:user)
    @rooms_tag = FactoryBot.build(:rooms_tag, user_id: user.id)
  end

  describe "room新規登録" do
    context '新規登録できるとき' do
      it "全項目入力で登録できる" do
        expect(@rooms_tag).to be_valid
      end

      it "タグが空でも登録できる" do
        @rooms_tag.name = ""
        expect(@rooms_tag).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'imageが空では保存できない' do
        @rooms_tag.image = nil
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleが空では保存できない' do
        @rooms_tag.title = ""
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Title can't be blank")
      end

      it 'titleが20文字以上では保存できない' do
        @rooms_tag.title = "abcdefghijklmnopqlstu"
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Title is too long (maximum is 20 characters)")
      end

      it 'contentが空では保存できない' do
        @rooms_tag.content = ""
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Content can't be blank")
      end

      it 'place_idが1の時保存できない' do
        @rooms_tag.place_id = 1
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Place must be other than 1")
      end

      it 'floor_idが1の時保存できない' do
        @rooms_tag.floor_id = 1
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Floor must be other than 1")
      end

      it 'style_idが1の時保存できない' do
        @rooms_tag.style_id = 1
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("Style must be other than 1")
      end

      it "user_idが空では登録できないこと" do
        @rooms_tag.user_id = nil
        @rooms_tag.valid?
        expect(@rooms_tag.errors.full_messages).to include("User can't be blank")
      end
  
    end

  end
end
