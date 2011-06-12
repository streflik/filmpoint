# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

product = Product.create(:name=>"dupa",:permalink=>"dupa")


User.create(:first_name=>"Bartek", :last_name=>"Rycharski", :email=>"bartlomiej.rycharski@gmail.com", :password=>"1231234", :password_confirmation=>"1231234")
User.create(:first_name=>"Krzysiek", :last_name=>"Streflik", :email=>"streflik@gmail.com", :password=>"1231234", :password_confirmation=>"1231234")
