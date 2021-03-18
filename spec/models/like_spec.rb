require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    user = FactoryBot.create(:user)
    room = FactoryBot.create(:room, user_id: user.id)
    @like = FactoryBot.build(:like, user_id: user.id, room_id: room.id)
  end

  describe "お気に入り機能" do
    context "お気に入りできる" do
      it "userとroomがあればお気に入りできる" do
        expect(@like).to be_valid
      end
    end

    context "お気に入りできない" do
      it "user_idが空ではお気に入りできない" do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("User must exist")
      end

      it "room_idが空ではお気に入りできない" do
        @like.room_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Room must exist")
      end
    end


  end

end
