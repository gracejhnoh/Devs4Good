# Devs4Good

Devs4Good is a platform where developers can give back to the community by bringing non-profit visions to life.

Devs4Good was built in 8 days by the following members of the 2017 "Rock Doves" cohort at DevBootcamp Seattle:
* [Cassi Gallagher-Shearer](http://linkedin.com/in/cassigallagher)
* [Grace Noh](http://linkedin.com/in/gracejhnoh)
* [Jorge Contreras-Loreto](http://linkedin.com/in/jorgeacl)
* [Jarred Taylor](http://linkedin.com/in/jarredtaylor)

## Functionality

You can browse the site as a logged-out visitor or, if you're a non-profit organization or developer, you can sign up for an account.

### As a logged out visitor, you can...
* browse available projects
* view non-profit and developer profiles

### As a non-profit, you can...
* fill out a profile
* provide your tax ID (know as an "EIN"). If provided, we display the name associated with that EIN to provide extra confidence as to your non-profit status
* post a technical project you need help with
* receive notifications about new proposals from developers who want to help with your project
* select a developer proposal for your project

### As a developer, you can...
* fill out a profile
* submit proposals for technical projects posted by non-profits
* receive notifications if your proposal is selected

## Technologies used
* Ruby on Rails
* PostgreSQL
* ActiveRecord
* JQuery
* ProPublica Non-Profit API
* Dragonfly (image processing)
* Amazon S3 (image storage)
* CKEditor (rich text entry)
* Sorcery
* Bourbon
* Travis CI
* SimpleCov
* Heroku

## How to install locally

1. Clone the repo and navigate to the main directory.
2. Install required gems: `bundle install`
3. Prepare the database:
  ```
  bundle exec rake db:create
  bundle exec rake db:migrate
  ```
4. There is a seed file with Faker-based data if you want to get a quicker view of the site's functionality: `bundle exec rake db:seed`.

5. The app is currently configured to use Amazon S3 for image storage in production (it stores images locally in development/test). You will need to replace with your own S3 information in `config/initializers/dragonfly.rb` and your own .env file.

6. The app is currently configured to use SMTP to send email notifications via Gmail. You will need to replace with your own Gmail information in `config/environments/development.rb` and/or `config/enviroments/production.rb`, and in your own .env file.

7. Run tests using `bundle exec rspec`. See test coverage by opening `coverage/index.html` after tests completed.
