require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'testlabel@example.com') }
  let!(:label) { FactoryBot.create(:label) }
  let!(:label2) { FactoryBot.create(:label,label_type: 'label2') }
  let!(:label3) { FactoryBot.create(:label,label_type: 'label3') }
  before do
    visit new_session_path
    fill_in 'session_email', with: 'testlabel@example.com'
    fill_in 'session_password', with: 'test01'
    click_on 'Log in'
    visit new_task_path
    fill_in 'task_name', with: 'テストラベル名前'
    fill_in 'task_content', with: 'テストラベル内容'
    day = Date.today + 5
    fill_in 'task_deadline', with: day
    check 'label1'
    check 'label2'
    select '完了', from: 'task[status]'
    click_on '登録する'
  end
  describe 'ラベル登録機能' do
    context 'タスクを新規作成するとき' do
      it 'タスクと一緒にラベルを登録できる' do
        expect(page).to have_content '登録しました'
        expect(page).to have_content 'ラベル: label1'
      end
    end
    context 'タスクを新規作成するとき' do
      it 'タスクと一緒に複数のラベルを登録できる' do
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end
    context 'タスクを新規作成したとき' do
      it '詳細画面で、そのタスクに紐づいているラベル一覧を出力できる' do
        expect(current_path).to eq task_path(Task.first)
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end
  end
  describe 'ラベル検索機能' do
    context 'タスク一覧画面でラベルを検索した時' do
      it '検索したラベルで絞ることができる' do
        visit new_task_path
        fill_in 'task_name', with: 'ラベル検索確認'
        fill_in 'task_content', with: 'ラベル検索確認'
        check 'label3'
        select '未着手', from: 'task[status]'
        click_on '登録する'
        visit tasks_path
        select 'label3', from: 'label_id'
        click_on '絞込み'
        expect(page).to have_content 'label2'
        expect(page).not_to have_content 'テストラベル名前'
      end
    end
  end
end
