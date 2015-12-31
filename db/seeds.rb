# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    User.create(email: "ilp416@gmail.com", password: "adminadmin", name: "Илья", roles_mask: 2)
    users= %w(dan  den  felipe  fernando  jenson  kimi  lewis  seb)
    users.each do |user|
      User.create(email: "#{user}@example.com", password: "#{user}-#{user}0", name: user, roles_mask: 1, avatar: File.new("#{Rails.root}/spec/images/avatar_#{user}.png"))
    end

    tasks = ["Заказ ", "Забронировать з.ч по счету ", "Разобраться с рекламацией %", "Анализ телеметрии #", "Подготовка тестов для проекта №", "Заявки по коду"]
    lorem_ipsum = 'Эа хаж фэугяат пльакырат, ад хаж льаорыыт аппэтырэ. Векж экз инимёкюж мыдиокрым. Нэ зыд дёко агам коррюмпит, пэр пырфэкто эррорибуз ку. Но долорюм факёльиси дёжжэнтиюнт шэа, эю квуй аюдиам ныглэгэнтур. Вяш форынчйбюж пэрчыквюэрёж ыт.'
    users = User.all
    20.times do 
      task = Task.create(name: "#{tasks[rand(tasks.size)]}#{rand(3482965..7165800)}", description: lorem_ipsum, author: users[rand(users.size)], executor: users[rand(users.size)])
      unless rand(2).zero?
        task.perform_event("start", task.executor)
        task.perform_event("finish", task.executor) if rand(2).zero?
        task.save
      end
    end
