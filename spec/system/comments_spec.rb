require 'rails_helper'

RSpec.describe "Comment投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, user_id: @user.id)
    @comment = FactoryBot.build(:comment, user_id: @user.id, room_id: @room.id)
  end

  it 'ログインしたユーザーは詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 詳細ページへ
    visit room_path(@room.id)
    # コメントを入力
    fill_in 'comment_text', with: @comment
    # コメント送信でコメントモデルのカウントが1上がる
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページへ
    expect(current_path).to eq room_path(@room.id)
    #  コメントが存在する
    expect(page).to have_content @comment
  end

  it 'ログインしていない場合コメント投稿フォームがない' do
    visit room_path(@room.id)
    expect(page).to have_no_content 'comment_text'
  end
end
