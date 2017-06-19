# Analytics Restarter

This app triggers nightly builds for the apps that makeup the [analytics.usa.gov](https://analytics.usa.gov) system. These apps include:

- [analytics.usa.gov](https://github.com/18F/analytics.usa.gov)
- [analytics-reporter](https://github.com/18F/analytics-reporter)
- [analytics-reporter-api](https://github.com/18F/analytics-reporter-api)

This service will restart CI builds for the above apps at 06:00 UTC every day.

## Deploy

To setup this app in cloud.gov, first deploy a user provided service to provide the app with the necessary information to start builds on circle. The app looks for a user provided service named `circleci`. It expects the service to have a key for each app referencing a JSON encoded string providing the repo name and a CircleCI token for the app.

For example:

```shell
$ cf cups -p ANALYTICS_USA_GOV,ANALYTICS_REPORTER,ANALYTICS_REPORTER_API

ANALYTICS_USA_GOV> {"NAME": "analytics.usa.gov","TOKEN": "123abc"}
ANALYTICS_REPORTER> {"NAME": "analytics-reporter","TOKEN": "456def"}
ANALYTICS_REPORTER_API> {"NAME": "analytics-reporter-api","TOKEN": "789ghi"}
```

This app also provides a route at `/` to provide an endpoint for New Relic uptime monitoring.

## Tests

This app ships with a lightweight testing suite. That can be run with `rspec`:

```
bundle install
bundle exec rspec
```
