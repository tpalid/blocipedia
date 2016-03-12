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
    email: "admin@example.com",
    password: "helloworld",
    role: "admin"
    )
admin.skip_confirmation!
admin.save!

user = User.new(
    name: "Admin",
    email: "user@example.com",
    password: "helloworld",
    role: "standard"
    )
user.skip_confirmation!
user.save!

stripe_user = User.new(
    name: "stripe_user",
    email: "stripeuser@stripe.com",
    password: "helloworld",
    customer_id: "cus_00000000000000",
    role: "standard"
    )
stripe_user.skip_confirmation!
stripe_user.save!

users = User.all

20.times do
    Wiki.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user: users.sample
        )
 end