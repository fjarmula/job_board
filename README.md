# Job Board

A Ruby on Rails application for publishing job offers and letting candidates apply. It supports recruiter/company accounts, authentication/authorization, background processing, and an optional scheduled sync job.

## Live demo

The app is currently deployed at: http://207.154.207.126/

Note: the connection is **not secure** right now (HTTP only; no TLS/HTTPS yet).

## Tech stack

- Ruby **3.4.5** (see `.ruby-version`)
- Rails **8.1**
- PostgreSQL
- Authentication: Devise
- Authorization: Pundit
- Background jobs: Solid Queue (`config/queue.yml`)
- Recurring jobs (production): `config/recurring.yml`
- Assets: Propshaft + Importmap + Turbo/Stimulus

## Getting started (local development)

### Prerequisites

- Ruby 3.4.5
- PostgreSQL (running locally)
- Bundler (usually included with Ruby)

### Setup

```sh
bundle install
bin/rails db:prepare
```

### Run the app

```sh
bin/dev
```

Then visit: http://localhost:3000

## Configuration

This app uses Rails credentials (encrypted `config/credentials.yml.enc`) for secrets.

### Environment variables

Common variables you may need:

- `RAILS_ENV` (default: `development`)
- `RAILS_MASTER_KEY` (required in production/Docker to decrypt credentials)
- `DATABASE_URL` (optional; standard Postgres URL)
- `DB_HOST` (production; used by `config/database.yml`)
- `RAILS_MAX_THREADS` (default: `5`; used for DB connection pool)
- `JOB_CONCURRENCY` (default: `1`; used by `config/queue.yml`)
- `RAILS_LOG_LEVEL` (production default: `info`)

### Credentials

Edit credentials:

```sh
bin/rails credentials:edit
```

Production database configuration reads:

- `Rails.application.credentials.db_url`

## Database

Create/migrate (safe to run repeatedly):

```sh
bin/rails db:prepare
```

Reset the database:

```sh
bin/rails db:reset
```

## Background jobs

Solid Queue is configured in `config/queue.yml`. In production, it is enabled via `config.active_job.queue_adapter = :solid_queue`.

### Running workers locally

If you enqueue jobs locally and want to process them, run a worker process in a separate terminal.

Depending on your Solid Queue version, one of these commands will be available:

```sh
bin/rails solid_queue:start
# or
bin/rails solid_queue:work
```

### Recurring jobs (production)

Production schedules are defined in `config/recurring.yml`, including:

- clearing finished Solid Queue jobs hourly
- `BulldogSyncJob` daily at 02:00

## Email in development

Emails are previewed in the browser via `letter_opener`.

## API

A small JSON API is exposed under `/api/v1`, for example:

- `GET /api/v1/companies/check_exists`

## Testing

This repo uses RSpec.

```sh
bundle exec rspec
```

System tests use Capybara + Selenium; you may need a compatible browser/driver available on your machine.

## Code quality and security

```sh
bin/rubocop
bin/brakeman
bin/bundler-audit
```

## Docker (production image)

The `Dockerfile` is designed for production.

Build:

```sh
docker build -t job_board .
```

Run (requires `RAILS_MASTER_KEY`):

```sh
docker run -d \
  -p 80:80 \
  -e RAILS_MASTER_KEY=... \
  -e DB_HOST=... \
  --name job_board \
  job_board
```

Note: the container entrypoint runs `bin/rails db:prepare` before starting the Rails server.

## Health check

- `GET /up` returns 200 when the app boots successfully.

## Troubleshooting

- **`ActiveSupport::MessageEncryptor::InvalidMessage`** (production/Docker): ensure `RAILS_MASTER_KEY` matches the key used to generate `config/credentials.yml.enc`.
- **Database connection errors**: confirm Postgres is running and `DATABASE_URL`/`DB_HOST` are set correctly.
- **Jobs not running**: start a Solid Queue worker process and confirm `JOB_CONCURRENCY` is > 0.
