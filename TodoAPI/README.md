# The API Layer

## Development

    bundle install
    rake db:create
    rails server

## The Stack

 - Barebones Ruby On Rails, with the `ruby-rails` gem
 - Custom user creation and authentication

## The API

To view and manipulate todos, you need to use a API key that will be given to you by the server once you signup or login.

An API key has an access token and an expiration date. You cannot use an expired API key.

In order to use an API key, you must include the token either in the **"access_token"** attribute in the request data, or in the **AccessToken** HTTP header.

### POST /api/users

Creates a new user. The email must be unique. Remember your password, you'll need it later to login.

Request data:

```json
{
    "email": "name@example.com",
    "password": "pass1234"
}
```

Response:

```json
{
    "api_key": {
        "access_token": "9ccc9365c72818f858d3cb243d8414aa",
        "expires_at": "2014-03-21T04:43:57.398Z"
    },
    "user": {
        "email": "name@example.com"
    }
}
```

### POST /api/sessions

You can generate new API Keys by "logging in".

Request data:

```json
{
    "email": "name@example.com",
    "password": "pass1234"
}
```

Response:

```json
{
    "api_key": {
        "access_token": "a6890498690ce41ccbf78c81b7dda568",
        "expires_at": "2014-03-21T04:51:17.384Z"
    },
    "user": {
        "email": "name@example.com"
    }
}
```

### DELETE /api/sessions

You can expire an API Key with this call.

