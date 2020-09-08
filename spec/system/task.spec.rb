require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'テスト詳細名前'
        fill_in 'task_content', with: 'テスト詳細内容'
        click_on '登録する'
        expect(page).to have_content 'テスト詳細名前'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task-Rspec')
        visit tasks_path
        expect(page).to have_content 'task-Rspe'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, name: '１つ目登録名前', content: '１つ目登録内容')
        task = FactoryBot.create(:task, name: '２つ目登録名前', content: '２つ目登録内容')
        visit tasks_path
        task_list = all('.task')
        expect(task_list[0]).to have_content '２つ目登録名前'
        expect(task_list[1]).to have_content '１つ目登録名前'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, name: '詳細表示機能名前', content: '詳細表示機能内容')
         visit tasks_path
         click_on '詳細'
         expect(page).to have_content '詳細表示機能名前'
       end
     end
  end
end
