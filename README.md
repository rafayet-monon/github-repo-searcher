# Github Repository Searcher

Simple application that can search to github for repositories.

> Warning: This app searches with unauthenticated requests. It can perform 10 requests per minute before you see a 
> error.

## Site link
#### Production: https://search-repo-production.herokuapp.com/
#### Staging: https://search-repo-staging.herokuapp.com/

## Application Screenshot
![screenshot](app-screenshot.png)

## Project Setup

### Prerequisites

- Ruby version: 2.7.2

### Development

* Setup the Postgres databases:

    ```sh
  rails db:setup
  ```

* Run the Rails app

    ```sh
    rails s
    ```

## Tests

This application have several type of tests
- Codebase tests (Checks for linting issues)
- Unit tests
- Request tests
- System tests (Uses headless chrome browser)

Use the command to run all the tests together

```sh
 bundle exec rspec
```

## Github CI

- On every Pull request the CI will run the tests.

## Github CD

- User `Heroku` for deployment
- Deploys to staging server on push to `development` branch
- Deploys to production server on push to `main` branch

#### You need to setup 3 secrets to the github repository for the deployment to work

- `HEROKU_API_KEY` - Heroku api access key
- `HEROKU_PRODUCTION_APP` - Heroku production app name
- `HEROKU_STAGING_APP` - Heroku staging app name

