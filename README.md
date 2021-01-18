# Artemis

![](https://i.imgur.com/j6rOu9y.gif)

Artemis is an API service that connects to social networks.

To test visit `http://localhost:3000/api/v1/social-networks`.

## Installation & Run


Simply run:
```
bundle install
```

*No database or background process needed as of this moment.*


```
rails s
```

Will run the API on port 3000.


## Tests

To run the test suite run:
```
bundle exec rspec
``` 

For **controllers** we run [request specs](https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec), being an API we want to truly hit the endpoints - including the routing.

At the moment we have no **models**/model specs. The app is configured to start testing data with: [factory bot](https://github.com/thoughtbot/factory_bot_rails), [faker](https://github.com/faker-ruby/faker) and [database cleaner](https://github.com/DatabaseCleaner/database_cleaner).


## Notes

#### SocialNetworkService

`SocialNetworkService` is configured to handle timeouts and invalid responses.

On success, it saves the responses to in memory cache and on future failures it gets back the previous cached response.

It's not bullet-proof as if there is an error on the first call it will return no data (`twitter: []`).  We could use a more persistent store/database (redis, postgres...) to  ensure there will be data available.

#### Endpoint

Endpoints are versioned.

Depending on who the API user is, it's would be good practice to return more information in endpoints e.g.:

```
{
  success: true,
  twitter: {
    success: false,
    error: "Timeout received",
    cached: true,
    body: [...]
  }
  ...
}
```

This lets the user understand the overall request was a success, but `twitter` run into hiccups and we returned a cached value.


#### Constants

Even though ruby is not a static language, having a `Constants` module helps expose hiccups. For example `SocialNetworkService.new(Constants::SocialNetworks::TWITTR)` would trigger an obvious error in Sentry/Rollbar and the tests.

```
uninitialized constant Constants::SocialNetworks::TWITTR
```

`social_network_domain` is defined in `config/application.rb` as the endpoint might differ between environment.

#### Tests

More through test are needed, the following would be priority:

- Social Network responds as expected based on errors encountered (e.g. timeout still returns an array)
- When a succesful call is made, and after a failed one, we get back the success call cached value 