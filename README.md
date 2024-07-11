* rails new todo_app
* bundle install
* rails generate scaffold Task title:string description:text completed:boolean
* rails db:migrate
* rails generate devise:install
* rails generate devise User
* rails g rolify Role User
* rails g pundit:install
* rails g pundit:policy Task
* rails generate migration AddUserIdToTasks user:references
