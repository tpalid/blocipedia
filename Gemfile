source 'https://rubygems.org'

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.5'
 
 group :production do
   gem 'pg'
   #use postgresql as database with heroku in production
   gem 'rails_12factor'
 end
 
 group :development do
   gem 'sqlite3'
   #use sqlite 3 as database in development
 end
 
 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'
 gem 'bootstrap-sass'
 #handling sensitive data
 gem 'figaro'
 gem 'pry'
 # user authentication
 gem 'devise'
 # authorization
 gem 'pundit'
 # stripe integration
 gem 'stripe'

 group :development, :test do
   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
   gem 'byebug'
   # Access an IRB console on exception pages or by using <%= console %> in views
   gem 'web-console', '~> 2.0'
   # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
   gem 'spring'
   # testing
   gem 'rspec-rails'
   gem 'shoulda'
   # create better fake data
   gem 'faker'
    #factories for testing
   gem 'factory_girl_rails'
 end
 
 
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development