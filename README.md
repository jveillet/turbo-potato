# turbo-potato

This is a sample rails 5 app to manage rides.

## Getting started

This project is using Ruby on Rails 5, PostgresSQL and RabbitMQ.

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
