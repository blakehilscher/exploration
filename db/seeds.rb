# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


{'blake@hilscher.ca' => 'bla548!', 'admin@explorationfitness.com' => 'exp444!'}.each do |e, p|
  u = Admin.find_or_initialize_by_email e
  u.update_attributes!(:password => p, :password_confirmation => p)
  p "User: #{u.email} Password: #{u.password}"
end