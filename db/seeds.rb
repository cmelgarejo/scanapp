# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
company = CreateCompanyService.new.call
ap "CREATED ADMIN COMPANY: #{company.name}"
ap 'CREATING ROLES:'
roles = CreateRolesService.new.call
ap 'CREATING CATEGORIES:'
categories = CreateCategoryService.new.call

user = CreateAdminService.new.call(company.id, roles, [categories[0]])
ap "CREATED ADMIN USER: #{user.name} - #{user.email}"
ap 'CREATING TEST ITEMS'
item1 = CreateItemService.new.call(company.id, 'Item 1', { fibra: nil }, true)
item2 = CreateItemService.new.call(company.id, 'Item 2', nil, false, item1)
item3 = CreateItemService.new.call(company.id, 'Item 3', nil, false, item1, [item2])
#item4 =
CreateItemService.new.call(company.id, 'Item 4', nil, false, item1, [item2, item3], [categories[0]])
## Have a form to create items with template: true
## and properties { key: value } to be the base for the rest