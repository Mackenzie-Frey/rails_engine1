# README

## Rails Engine
Rails Engine is an application which delivers JSON-formatted data related to customers, merchants, items, invoices, invoice_items and transactions, stored in a postsql database.

### Schema:
![Alt text](./public/schema_diagram.png?raw=true "Database Schema")

### Setup
First, clone this repository:

`git clone git@github.com:Mackenzie-Frey/rails_engine.git`
`cd rails_engine`

On the command line (from with in the project directory), run the following commands:
`bundle install`
`rake db:{drop,create,migrate}` - This creates migrations and migrates them into the database.
`rake import:all` - This imports the data from the CSV files.

#### Running The Tests
The command `rspec` can be utilized to run the local test suite.

### Running On A Server
On the command line (from within the project directory), run: `rails s`

Open up a web browser.

Navigate to `localhost:3000/`

### Built Utilizing

* Rails
* PostreSQL
* RSpec
* FactoryBot
* ShouldaMatchers
* SimpleCov
* Capybara
* Pry

### Project Management

[GitHub](https://github.com/) - Version Control
[Waffle.io](https://waffle.io/) - Project Management Tool

### Authors

* Mackenzie Frey
