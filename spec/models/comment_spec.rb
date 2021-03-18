require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = FactoryBot.create(:user)
    room = FactoryBot.create(:room, user_id: user.id)
    @comment = FactoryBot.build(:comment, user_id: user.id, room_id: room.id)
  end

  describe "comment投稿機能" do
    context "投稿できる" do
      it "揃うことで投稿できる" do
        expect(@comment).to be_valid
      end
    end

    context "投稿できない" do
      it "textが空では投稿できない" do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end

      it "textが140字以上では投稿できない" do
        @comment.text = "a"*141
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text is too long (maximum is 140 characters)")
      end

      it "user_idが空では登録できない" do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User must exist")
      end

      it "room_idが空では登録できない" do
        @comment.room_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Room must exist")
      end

    end
  end

end
