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


RSpec.describe 'Room編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @room1 = FactoryBot.create(:room, user_id: @user1.id)
    @room2 = FactoryBot.create(:room, user_id: @user2.id)
  end

  context '編集ができるとき' do
    it '本人は自分が投稿したRoomの編集ができる' do
      # room1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # マイページへ遷移する
      find('button[class="mobile-menu__btn"]').click
      visit user_path(@room1.user.id)
      expect(page).to have_content('模様替え')
      # 編集ページへ遷移する
      visit edit_room_path(@room1)
      # 内容が存在する
      expect(
        find('#room_title').value
      ).to eq(@room1.title)
      expect(
        find('#room_content').value
      ).to eq(@room1.content)
      # 情報を加える
      image_path = Rails.root.join('public/images/test.png')
      attach_file('room[image]', image_path, make_visible: true)
      fill_in 'room[title]', with: "#{@room1.title}っす"
      fill_in 'room[content]', with: "#{@room1.content}ですよ！"
      # Roomモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(0)
      #room/showへ遷移する
      expect(current_path).to eq room_path(@room1.id)
      expect(page).to have_content("#{@room1.title}っす")
    end
  end

  context '編集できないとき' do
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      visit root_path
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_content("ログイン")
    end
  end
end


RSpec.describe 'Room削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, user_id: @user.id)
  end

  context 'Room削除ができるとき' do
    it '自らが投稿したRoomの削除ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # マイページへ遷移する
      find('button[class="mobile-menu__btn"]').click
      visit user_path(@room.user.id)
      expect(page).to have_content('部屋を削除する')
      # 削除する
      expect{
        find_link('部屋を削除する', href: room_path(@room.id)).click
      }.to change { Room.count }.by(-1)
      # 削除後トップページへ遷移する
      expect(current_path).to eq root_path
    end
  end

  context 'Room削除できないとき' do
    it 'ログインしていないとツイートの削除ボタンがない' do
      visit root_path
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_content("ログイン")
    end
  end

end

RSpec.describe 'Room詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, user_id: @user.id)
  end

  it '詳細ページに遷移して内容を確認できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 詳細ページへ
    visit room_path(@room)
    # 詳細ページにRoomの内容が含まれている
    expect(page).to have_content("#{@room.title}")
    expect(page).to have_content("#{@room.content}")
  end
end