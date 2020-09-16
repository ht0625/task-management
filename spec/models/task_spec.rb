require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user,email:'test111@example.com') }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', content: '', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト名前', content: '成功テスト内容', user: user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        task1 = FactoryBot.create(:task, name: 'task', user: user)
        task2 = FactoryBot.create(:task, name: "sample", user: user)
        expect(Task.name_search('task')).to include(task1)
        expect(Task.name_search('task')).not_to include(task2)
        expect(Task.name_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        task1 = FactoryBot.create(:task, name: 'task1', user: user)
        task2 = FactoryBot.create(:task, name: "task2", status: "完了", user: user)
        expect(Task.status_search('完了')).to include(task2)
        expect(Task.status_search('完了')).not_to include(task1)
        expect(Task.status_search('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task1 = FactoryBot.create(:task, name: 'task', user: user)
        task2 = FactoryBot.create(:task, name: "task", status: "完了", user: user)
        task3 = FactoryBot.create(:task, name: "aaa", status: "完了", user: user)
        expect(Task.name_search('task').status_search('完了')).to include(task2)
        expect(Task.name_search('task').status_search('完了')).not_to include(task1)
        expect(Task.name_search('task').status_search('完了').count).to eq 1
      end
    end
  end
end
