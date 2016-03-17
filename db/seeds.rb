5.times do
    user = User.new(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Lorem.characters(10)
        )
    user.skip_confirmation!
    user.save!
end

admin = User.new(
    name: "Admin",
    email: "admin@email.com",
    password: "helloworld",
    role: "admin"
    )
admin.skip_confirmation!
admin.save!

premium_user = User.new(
    name: "Premium",
    email: "premium@email.com",
    password: "helloworld",
    role: "premium"
    )
premium_user.skip_confirmation!
premium_user.save!

standard_user = User.new(
    name: "Standard",
    email: "standard@email.com",
    password: "helloworld",
    role: "standard"
    )
standard_user.skip_confirmation!
standard_user.save!

users = User.all
premium_users = [admin, premium_user]
10.times do
    Wiki.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user: users.sample,
            )
 end
 
 10.times do
    Wiki.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user: premium_users.sample,
        private: true
            )
 end
 
 wikis = Wiki.all
 
 30.times do
     Collaborator.create!(
         user_id: users.sample.id,
         wiki_id: wikis.sample.id
         )
     end