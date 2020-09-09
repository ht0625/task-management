# README

### User

| カラム名 |  データ型  |
| ----| ---- |
|  name  |  string  |
|  email  |  string  |
|  password  |  string  |

### Task

| カラム名 |  データ型  |
| ----| ---- |
|  name  |  string  |
|  content  |  string  |
|  priority  |  integer  |
|  deadline  |  date  |
|  status  |  string  |
|  user_id  |  integer  |

### Connect

| カラム名 |  データ型  |
| ----| ---- |
|  task_id  |  integer  |
|  label_id  |  integer  |

### Label

| カラム名 |  データ型  |
| ----| ---- |
|  type  |  string  |

## Herokuへのデプロイ方法

* Herokuへログインする
`$ heroku login`

* アセットプリコンパイルをする
`$ rails assets:precompile RAILS_ENV=production`

* Herokuに新しいアプリケーションを作成する
`$ heroku create`

* Heroku buildpackを追加
`$ heroku buildpacks:set heroku/ruby`

* Herokuにデプロイをする
`$ git push heroku master`

* データベースの移行
`$ heroku run rails db:migrate`
