# ss_api_endpoint_takehome
## About this Project
Take-home challenge for SS. Create tables, model validations, and endpoints for an API only app. Authenticate w/ JWT. Create documentation for API endpoints. Answer technical questions. Reflect on JSON Web Token usage. Demonstrate project management. And most importantly, have a great time learning! 

Thank you to SS for the opportunity!
## Table of Contents
  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Technologies Used](#technologies-used)
  - [Versioning](#versioning)
  - [Authors](#authors)
## Getting Started
To run the web application on your local machine, you can fork and clone down the repo and follow the installation instructions below.
### Prerequisites
To run this application you will need `Ruby 2.7.2` and `Rails 5.2.6` 

(This was supposed to be in `Rails 6.0.2` but I made a mistake! Super sorry about that. 
### Installing
First you'll need to:
1) `bundle install` 
2) `rails db:{create,migrate,seed}`

Congratulations! Basic setup is now complete. That should be all you need to complete installation!

## Running the tests
RSpec testing suite is utilized for testing this application.
 - Run the RSpec suite to ensure everything is passing as expected
`bundle exec rspec`
## DB Schema
![Find My City Schema](https://github.com/kon-ham/ss_api_endpoint_takehome/blob/main/Screen%20Shot%202021-10-04%20at%209.48.54%20PM.png?raw=true)

## API Endpoints
 Please see the `api_calls_responses.md` file located in the `root` directory of this repository for API endpoints and responses.
## Technologies Used
- Ruby
- Rails
- RSpec
- PostgreSQL
## Gems Used
- factory_bot_rails
- faker
- rack-cors
- bcrypt
- shoulda-matchers
## Versioning
- Ruby 2.7.2
- Rails 5.2.6
## Authors
- **Kon Ham**
  [LinkedIn](https://www.linkedin.com/in/kon-ham) | 
  [GitHub](https://github.com/kon-ham)
