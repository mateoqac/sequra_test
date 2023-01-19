# README

This README would help you to setup the environment to run the application.

### System requirements:

- `Ruby version: 3.1.2`
- `Rails version: 7.0.4.1`

You can check if they are installed by running the commands `ruby -v` and
`rails -v` in your terminal.

- `Database: PostgreSQL 11.18`
- `Redis`

### Downloading the repository

1. Open a terminal and navigate to the directory where you want to download the
   repository.

2. Run the command `git clone https://github.com/mateoqac/sequra_test.git` to
   download the repository.

### Creating the database

1. Navigate to the root of the repository directory in the terminal.

2. Run the command rails db:create to create the database.

3. Run the command rails db:migrate to run the database migrations.

> if you get an error you can run the following command:
>
> `gem install pg -- --with-pg-config=/usr/local/bin/pg_config`

### Seeding the database

1. Make sure you are still in the root of the repository directory in the
   terminal.

2. Run the command rails db:seed to seed the database with data.

3. Once the command completes, you should now have a fully functional and seeded
   database for the application.

### Calculate and persist the disbursements per merchant on a given week

1. Make sure you are still in the root of the repository directory in the
   terminal.

2. Run the command `bundle exec sidekiq` to start the Sidekiq server.

3. Run the command `rails c` to start the rails console.

4. Run the command `DisbursementJob.perform_async('YYYY-MM-DD')` to enque a job
   to calculate and persist the data.

5. You can exit with the command `ctrl + c`

### Run the server

1. Make sure you are still in the root of the repository directory in the
   terminal.

2. Run the command `rails s` to start the Rails Server

### Get disbursements for a given merchant on a given week. If no merchant is provided return for all of them.

1. Open another terminal tab (Make sure you are still in the root of the
   repository directory) and Run the command:

```
curl -X GET \
  -H "Content-type: application/json" \
  -H "Accept: application/json" \
  -d '{"week":"2023-01-19", "merchant_id":"9"}' \
  "http://localhost:3000/api/disbursements"
```
