namespace :db do
  desc "populate members"
  task populate_members: :environment do
    Faker::Config.locale = :en
    6.times do |n|
      email = "jobseeker#{n+1}@example.com"
      puts email
      password = '123qweASD!'
      password_confirmation = '123qweASD!'
      user = User.new(
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      address_1 = Faker::Address.street_address
      address_2 = Faker::Address.secondary_address
      city = Faker::Address.city
      state = Faker::Address.state
      zip_code = Faker::Address.zip_code
      phone = Faker::PhoneNumber.phone_number
      work_experience = Faker::Lorem.paragraphs(rand(2..8)).join('\n')
      volunteer_experience = Faker::Lorem.paragraphs(rand(2..8)).join('\n')
      user.role = Member.new(
        first_name: first_name,
        last_name: last_name,
        address_1: address_1,
        address_2: address_2,
        city: city,
        state: state,
        zip_code: zip_code,
        phone: phone,
        volunteer_experience: volunteer_experience,
        work_experience: work_experience
      )
      user.save!
    end
  end
  desc "populate employers"
  task populate_employers: :environment do
    Faker::Config.locale = :en
    6.times do |n|
      email = "employer#{n+1}@example.com"
      puts email
      password = '123qweASD!'
      password_confirmation = '123qweASD!'
      user = User.new(
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
      company = Faker::Company.name
      description = Faker::Company.catch_phrase
      user.role = Employer.new(
        company: company,
        description: description
      )
      user.save!
    end
  end
  desc "populate admin"
  task populate_admin: :environment do
    Faker::Config.locale = :en
    email = "admin1@example.com"
    puts email
    password = '123qweASDzxc!@#'
    password_confirmation = '123qweASDzxc!@#'
    user = User.new(
      email: email,
      password: password,
      password_confirmation: password_confirmation
    )
    user.role = Admin.new(
    )
    user.save!
  end
  desc "populate openings"
  task populate_openings: :environment do
    Faker::Config.locale = :en
    99.times do |n|
      date_range = rand(1..60)
      employer_id = rand(1..6)
      active = true
      position = Faker::Lorem.words(rand(2..5)).join(' ')
      puts position
      description = Faker::Lorem.paragraphs(rand(2..8)).join('\n')
      date_open = Date.today + n - date_range
      date_closed = Date.today + n + date_range
      city = Faker::Address.city
      state = Faker::Address.state
      zip_code = Faker::Address.zip_code
      Opening.create!(
        employer_id: employer_id,
        active: active,
        position: position,
        description: description,
        date_open: date_open,
        date_closed: date_closed,
        city: city,
        state: state,
        zip_code: zip_code
      )
    end
  end
  desc "populate interests"
  task populate_interests: :environment do

    Interest.create([
      { name: 'Food service' },
      { name: 'Medicare' },
      { name: 'Nutrition' },
      { name: 'Communications' },
      { name: 'Fund raising' },
      { name: 'Government liaison' }
    ])
    puts "Creating interests"
  end
  desc "perform all populations"
  task :populate_all do
    Rake::Task['db:populate_members'].invoke
    Rake::Task['db:populate_employers'].invoke
    Rake::Task['db:populate_admin'].invoke
    Rake::Task['db:populate_openings'].invoke
    Rake::Task['db:populate_interests'].invoke
  end
end