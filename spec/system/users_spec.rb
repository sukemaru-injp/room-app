require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページ
      visit root_path
      # サインアップページへ
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      # ユーザー情報
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password Confirmation', with: @user.password_confirmation
      select @user.sex.name, from: "user_sex_id"
      # ユーザーが増える
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ
      expect(current_path).to eq(root_path)
      # 新規登録、ログインボタンがない
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできる' do
    it 'ユーザー情報が正しければログインできる' do
      # トップページ
      visit root_path
      # サインアップページへ
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      # 正しいユーザー情報入力
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      # トップページへ
      expect(current_path).to eq(root_path)
      # 新規登録、ログインボタンがない
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインできないとき' do
    it 'ユーザー情報が正しくなければログインできない' do
      # トップページ
      visit root_path
      # サインアップページへ
      find('button[class="mobile-menu__btn"]').click
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      #誤ったユーザー情報を入力
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      find('input[name="commit"]').click
      # ログインページへ戻る
      expect(current_path).to eq(new_user_session_path)
    end
  end

end

