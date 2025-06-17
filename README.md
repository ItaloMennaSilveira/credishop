# Impulso – Tech Challenge

This project was developed as part of the Impulso Challenge for Credishop with the following main goals:

- Provide a functional solution to the proposed challenges;
- Demonstrate proficiency in [Ruby on Rails](https://rubyonrails.org/) and supporting technologies;
- Follow best practices in code organization, testing, and containerization.

---

## Technologies Used

- [Ruby 3.3.6](https://www.ruby-lang.org/en/)
- [Rails 8.0.2](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Bootstrap](https://getbootstrap.com/)
- [Slim](https://slim-template.github.io/)
- [Chart.js](https://www.chartjs.org/)

### Additional Gems

- [Byebug](https://github.com/deivid-rodriguez/byebug) – Debugging tool
- [CSS Bundling](https://github.com/rails/cssbundling-rails) – Handles asset pipeline for CSS in Rails projects
- [CPF_CNPJ](https://github.com/fnando/cpf_cnpj) – Validation and formatting for Brazilian CPF and CNPJ numbers
- [Devise](https://github.com/heartcombo/devise) – Authentication solution for Rails applications
- [FactoryBot Rails](https://github.com/thoughtbot/factory_bot_rails) – Factories for use with RSpec tests
- [Faker](https://github.com/faker-ruby/faker) – Fake data generator for tests
- [Kaminari](https://github.com/kaminari/kaminari) – Pagination library for Rails
- [Rails Controller Testing](https://github.com/rails/rails-controller-testing) – Adds controller testing support to Rails
- [RSpec Rails](https://github.com/rspec/rspec-rails) – Testing framework for Rails
- [Rubocop](https://github.com/rubocop/rubocop-rails) – Linter and formatter to enforce Rails code style
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) – Common matchers for model and controller tests
- [Sidekiq](https://sidekiq.org/) – Background job processing with Redis
- [Slim](https://github.com/slim-template/slim-rails) – Lightweight templating engine for Rails views

---

## Completed Tasks

As requested in the challenge proposal, all requirements were implemented:

### Minimum Requirements

- **_Seed the database with at least 10 records_**
  The application uses seeds that initialize 20 `proponents`, each with 1–2 `addresses` and 1–3 `contacts`, processed by the `ProponentSeedJob` via Sidekiq.

- **_Use pagination with 5 records per page_**
  Pagination is implemented using Kaminari. The `proponents#index` displays paginated tables grouped by INSS rate, with 5 `proponents` per table.

- **_Include a background job where appropriate_**
  Two background jobs exist:
  `ProponentSeedJob` to populate the database,
  `InssRateCalculatorJob` to calculate the INSS rate asynchronously and update it on the front end using ActionCable.

- **_Use Rubocop to follow Rails best practices_**
  The project uses Rubocop to ensure code quality and formatting aligned with community standards.

### Desired Features

- **_User authentication_**
  The app requires login. A default user is created when seeds are run. Without login, it's not possible to access the `proponents` CRUD.

- **_Automated tests_**
  All Rails files containing logic are tested using RSpec, along with support gems like FactoryBot and Faker.

### Bonus Features

- **_Dockerization_**
  The entire app runs inside Docker containers.

- **_Template engine_**
  All views use the [Slim](https://slim-template.github.io/) templating language.

### Additional Information

- All commits follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.
- Field validations in the views use [IMask.js](https://imask.js.org/).
- Address auto-fill uses [ViaCEP](https://viacep.com.br) on the client side.

---

## Requirements

This project runs entirely via Docker. Please ensure the following are installed:

- [Docker](https://docs.docker.com/) (version 20.10+)
- [Docker Compose](https://docs.docker.com/compose/) (version 2.0+)

> **Tested on macOS with:**
> - Docker: `27.3.1 (build ce1223035a)`
> - Docker Compose: `v2.31.0-desktop.2`

---

## Running and Using the Project

### 1. Start the application

```bash
docker-compose up --build
```

### 2. Create the database and run migrations

```bash
docker-compose run web rails db:create db:migrate
```

### 3. Seed the database

```bash
docker-compose exec web rails db:seed
```

### 4. Access in the browser

Visit:
```
http://localhost:3000
```
Use the seeded user credentials:
**Email:** `admin_user@email.com`
**Password:** `admin_user`

### 5. Run the test suite

```bash
docker-compose exec web bundle exec rspec
```

---

## Future Improvements

- Use `i18n` for translating field names, validation messages, and general UI text.
- Add additional model validations as business rules are refined.
- Add SQL indexes to optimize queries on large datasets.
- Improve styling and UX on the front end.