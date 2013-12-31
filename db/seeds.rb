### USING FAKER INSTEAD - lib/tasks/sample_data.rake
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# user1 = User.new(
# 	:email => 'member1@example.com',
# 	:password => '123qweASD',
# 	:password_confirmation => '123qweASD'
# )
# user1.role = Member.new(
# 	:first_name => "Rock",
# 	:last_name => "Hudson",
# 	:address_1 => "PO Box 12345",
# 	:address_2 => "",
# 	:city => 'Anytown',
# 	:state => 'Anystate',
# 	:zip_code => '11111',
# 	:phone => "111.222.3333",
# 	:volunteer_experience => "None",
# 	:work_experience => "Fast Food"
# )
# user1.save!

# user2 = User.new(
# 	:email => 'employer1@example.com',
# 	:password => '123qweASD',
# 	:password_confirmation => '123qweASD'
# )
# user2.role = Employer.new(
# 	:company => "Widgets, Inc.",
# 	:description => 'Free widgets to the homeless',
# )
# user2.save!

# Opening.create(
# 	:active => true,
# 	:position => 'Rails programmer',
# 	:date_open => Date.today,
# 	:date_closed => Date.today + 30.days,
# 	:employer_id => user2.role_id,
# 	:description => "Located in Mytown, Colorado, we are looking to build a 'Monster Job' board for Employers..."
# )

# Interest.create([
#   { name: 'Food service' },
#   { name: 'Medicare' },
#   { name: 'Nutrition' },
#   { name: 'Communications' },
#   { name: 'Fund raising' },
#   { name: 'Government liaison' }
# ])