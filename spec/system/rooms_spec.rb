require 'rails_helper'

RSpec.describe "Room投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.build(:room)
  end

  context 'roomが投稿できるとき' do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿ページへのリンクがある
      expect(page).to have_content('投稿する')
      # 投稿ページへ
      visit new_room_path
      # 情報を入力する
      image_path = Rails.root.join('public/images/test.png')
      attach_file('room[image]', image_path, make_visible: true)
      fill_in 'room[title]', with: @room.title
      fill_in 'room[content]', with: @room.content
      select @room.place.name, from: "room_place_id"
      select @room.floor.name, from: "room_floor_id"
      select @room.style.name, from: "room_style_id"
      # 投稿する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
      # トップページに遷移している
      expect(current_path).to eq root_path
      # 投稿したものがトップページにある
      expect(page).to have_content(@room.title)
    end
  end

  context 'roomが投稿できない' do
    it 'ログインが必要である' do
      visit root_path
      expect(page).to have_content('投稿する')
      visit new_room_path
      # 投稿ページへいこうとするとログインページへ
      expect(current_path).to eq new_user_session_path
    end
  end
end
