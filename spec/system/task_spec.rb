require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user,email:'test111@example.com') }
  let!(:task) { FactoryBot.create(:task, name: '１つ目登録名前', content: '１つ目登録内容', user: user) }
  let!(:task2) { FactoryBot.create(:task, name: '２つ目登録名前', content: '２つ目登録内容', user: user) }
  before do
    visit new_session_path
    fill_in 'session_email', with: 'test111@example.com'
    fill_in 'session_password', with: 'test01'
    click_on 'Log in'
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'テスト詳細名前'
        fill_in 'task_content', with: 'テスト詳細内容'
        day = Date.today + 5
        fill_in 'task_deadline', with: day
        select '完了', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content 'テスト詳細名前'
        expect(page).to have_content day
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content '１つ目登録名前'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('tr')
        expect(task_list[1]).to have_content '２つ目登録名前'
        expect(task_list[2]).to have_content '１つ目登録名前'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順にソートされ表示される' do
        tomorrow = Date.today + 1
        FactoryBot.create(:task, name: '３つ目登録名前', content: '３つ目登録内容', deadline: tomorrow, user: user)
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 1.0
        task_list = all('tr')
        expect(task_list[1]).to have_content tomorrow
        expect(task_list[2]).to have_content Date.today
      end
    end
    context '優先度でソートするボタンを押した場合' do
      it '優先度の降順にソートされ表示される' do
        task = FactoryBot.create(:task, name: '３つ目登録名前', content: '３つ目登録内容', priority: '高', user: user)
        visit tasks_path
        click_on '優先度でソートする'
        sleep 1.0
        task_list = all('tr')
        expect(task_list[1]).to have_content '高'
        expect(task_list[2]).to have_content '中'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit tasks_path
         first('#task').click_link '詳細'
         expect(page).to have_content '２つ目登録名前'
       end
     end
   end
  describe '検索機能' do
    before do
      FactoryBot.create(:task, name: "task", user: user)
      FactoryBot.create(:task, name: "sample", status:'着手中', user: user)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[name_key]', with: 'task'
        click_on '検索'
        expect(page).to have_content 'task'
        expect(page).not_to have_content 'sample'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '着手中', from: 'task[status_key]'
        click_on '検索'
        expect(page).to have_content 'sample'
        expect(page).not_to have_content 'task'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        FactoryBot.create(:task, name: "task", status:'着手中', user: user)
        visit tasks_path
        fill_in 'task[name_key]', with: 'task'
        select '着手中', from: 'task[status_key]'
        click_on '検索'
        expect(page).to have_content 'task'
        expect(page).not_to have_content 'sample'
        expect(all('.task').count).to eq 1
      end
    end
  end
end
