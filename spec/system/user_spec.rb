require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'テスト名前'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'test01'
        fill_in 'user_password_confirmation', with: 'test01'
        click_on '作成'
        expect(page).to have_content 'テスト名前のページ'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログインが必要です'
      end
    end
  end
  describe 'セッション機能' do
    before do
      @user = FactoryBot.create(:user, name: 'ログイン名前')
      visit new_session_path
      fill_in 'session_email', with: 'test111@example.com'
      fill_in 'session_password', with: 'test01'
      click_on 'Log in'
    end
    context '登録したユーザーでログインした場合' do
      it 'ログインできること' do
        expect(page).to have_content 'ログイン名前のページ'
      end
    end
    context '登録したユーザーでログインしている時' do
      it '自分の詳細ページに飛べること' do
        expect(page).to have_content 'ログイン名前のページ'
        expect(current_path).to eq user_path(@user.id)
      end
    end
    context '一般ユーザが他人の詳細画面にアクセスした時' do
      it 'タスク一覧画面に遷移すること' do
        visit user_path(User.first.id + 1)
        expect(current_path).to eq tasks_path
        expect(page).to have_content '他者のプロフィールは見れません'
      end
    end
    context 'ログインしている時' do
      it 'ログアウトできること' do
        click_on 'ログアウト'
        FactoryBot.create(:user, name: 'ログイン名前2人目',email:'test112@example.com')
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面' do
    before do
      FactoryBot.create(:user,name:'admin',email:'admin@example.com',admin: true)
      visit new_session_path
    end
    context '登録した管理ユーザでログインした場合' do
      it '管理画面にアクセスできること' do
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content 'アカウント一覧'
      end
    end
    context '登録した一般ユーザで管理画面にアクセスした場合' do
      it '管理画面にアクセスできないこと' do
        FactoryBot.create(:user,name:'admin',email:'test111@example.com')
        fill_in 'session_email', with: 'test111@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '登録した管理ユーザで新規ユーザを作成した場合' do
      it 'ユーザーが作成できること' do
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit new_admin_user_path
        fill_in 'user_name', with: 'テスト名前'
        fill_in 'user_email', with: 'test@example.com'
        check 'user_admin'
        fill_in 'user_password', with: 'test01'
        fill_in 'user_password_confirmation', with: 'test01'
        click_on '作成'
        expect(page).to have_content 'テスト名前'
        expect(current_path).to eq admin_users_path
      end
    end
    context '登録した管理ユーザでユーザの詳細画面にアクセスした場合' do
      it 'アクセスできること' do
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit admin_user_path(User.first)
        expect(page).to have_content 'adminのページ'
      end
    end
    context '登録した管理ユーザでユーザ編集しようとした場合' do
      it '編集できること' do
        fill_in 'session_email', with: 'admin@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit edit_admin_user_path(User.first)
        fill_in 'user_name', with: '名前を追加'
        click_on '作成'
        expect(page).to have_content '名前を追加'
        expect(current_path).to eq admin_users_path
      end
    end
    context '登録した管理ユーザでユーザを削除しようとした場合' do
      it '削除できること' do
        FactoryBot.create(:user,name:'サンプル',email:'test1111@example.com',admin: true)
        fill_in 'session_email', with: 'test1111@example.com'
        fill_in 'session_password', with: 'test01'
        click_on 'Log in'
        visit admin_users_path
        page.accept_confirm do
          first('#task').click_link '削除'
        end
        expect(page).to have_content '削除しました'
        expect(page).not_to have_content 'admin'
      end
    end
  end
end
