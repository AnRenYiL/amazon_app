User.destroy_all
Product.destroy_all
Review.destroy_all

NUM_PRODUCTS = 40
NUM_USERS = 3
PASSWORD = "supersecret"
super_user = User.create(
    first_name: "Mao",
    last_name: "Li",
    email: "anrenyil@gmail.com",
    password:'123',
    is_admin: true
)
NUM_USERS.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
        password: PASSWORD
    )
end
users = User.all
NUM_PRODUCTS.times do
  created_at = Faker::Date.backward(days: 365 * 5)
  p = Product.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    price: rand(100_000),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if p.valid?
    p.reviews = rand(0..10).times.map do
      Review.new(body: Faker::GreekPhilosophers.quote,rating: rand(1..5), user: users.sample)
    end
  end
end
puts 'success'
# puts Cowsay.say("Generated #{Product.all.count} products", :frog)
# puts Cowsay.say("Generated #{Review.count.count} answers", :stegosaurus)
# puts Cowsay.say("Generated #{users.count} users", :tux)
# puts "Login with #{super_user.email} and password: #{PASSWORD}"