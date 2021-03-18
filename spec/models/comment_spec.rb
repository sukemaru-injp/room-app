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
  end

end
