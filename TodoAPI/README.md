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

Each user has a unique API key. If the user desires, they can reset it, generating a new one.

You cannot use an expired API key. Once it's expired, a new one will be generated. Use the login call to obtain it.

In order to use an API key, you must include the token either in the **"api_key"** attribute in the request data, or in the **ApiKey** HTTP header.

The API is documented in the RAML file.
