# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    User.create(email: "ilp416@gmail.com", password: "adminadmin", name: "Илья", roles_mask: 1)
    User.create(email: "kimi@gmail.com", password: "kimikimi", name: "Kimi", roles_mask: 2)
    User.create(email: "mika@gmail.com", password: "mikamika", name: "Mika", roles_mask: 2)
    User.create(email: "seb@gmail.com", password: "sebsebseb", name: "Sebastian", roles_mask: 2)
    User.create(email: "den@gmail.com", password: "dendenden", name: "Deniel", roles_mask: 2)
    User.create(email: "juan@gmail.com", password: "juanjuan", name: "Juan", roles_mask: 2)
    User.create(email: "phidel@gmail.com", password: "phidelkastro", name: "Phidel", roles_mask: 2)
    User.create(email: "Fernando@gmail.com", password: "Fernando", name: "Fernando", roles_mask: 2)
    User.create(email: "jenson@gmail.com", password: "jensonbutton", name: "Jenson", roles_mask: 2)
    User.create(email: "lewis@gmail.com", password: "lewislewis", name: "Lewis", roles_mask: 2)
