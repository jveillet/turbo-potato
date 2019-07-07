# turbo-potato

This is a sample rails 5 app to manage rides.

## Getting started

This project is using Ruby on Rails 5, PostgresSQL and RabbitMQ.

![IMG_20190704_233027](https://user-images.githubusercontent.com/5037407/60765802-412a1800-a0a0-11e9-8a4c-85f43d03baba.jpg)

### Features

Turbo Potato can managed rides (create, edit, update).

A ride can have 3 states:
+ `Created`: That's when we have created a new ride request, this state creates a bill.
+ `started`: That's when we have started the ride, this state is paying the bill.
+ `canceled`: That's when we have cancelled the ride, the bill is refunded.

Additionally, the ride can be deleted at any state.

For every change of the ride's state, a message is published on RabbitMQ containing the Ride Object, so that external systems can be aware of the changes.

### Install

Install the project using Docker and docker-compose:
```
$ docker-compose build
```

Then run the full project
```
$ docker-compose up
```

### Database initialization

```
$ docker-compose run --rm web rails db:create
```

```
$ docker-compose run --rm web rails db:migrate
```

It is possible to create some sample data by launching:
```
$ docker-compose run --rm web rails db:seed
```

### RabbitMQ Configuration

We need to supply an URL in order for the app to connect with RabbitMQ.
When calling `Bunny.new` in the code to initialize the connection, the `bunny` gem
looks first into the environment variables to `RABBITMQ_URL` in order to make the connection.

We will use the `dotenv-rails` gem to supply this environment variable to the app.

Create a `.env` file at the root of the project, and add the URL of RabbitMQ inside:
```
$ cd turbo-potato/
$ touch .env
$ echo "RABBITMQ_URL='amqp://172.17.0.1:5672'" >> .env
```

## Testing
Launch the entire test suite (with RSpec):
```
$ docker-compose run --rm web rspec
```

## Contributing

Thanks for considering to contribute to the project! 🎉

This project only accepts pull requests related to open issues.
If suggesting a new feature or change, please discuss it in an issue first.

+ Fork the project
+ Create a descriptively named feature branch (example: ISSUE-number_Name_of_your_branch)
+ Add your feature
+ Submit a pull request
