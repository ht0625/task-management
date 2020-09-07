require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'テスト詳細名前'
        fill_in 'task_content', with: 'テスト詳細内容'
        click_on 'Create Task'
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
