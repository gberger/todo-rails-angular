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

### POST `/api/users/signup`

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
    "api_key": "9ccc9365c72818f858d3cb243d8414aa",
    "api_key_expires_at": "2014-03-21T04:43:57.398Z",
    "email": "name@example.com"
}
```

### POST `/api/users/login`

You can get your API key by "logging in".

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
    "api_key": "9ccc9365c72818f858d3cb243d8414aa",
    "api_key_expires_at": "2014-03-21T04:43:57.398Z",
    "email": "name@example.com"
}
```

### PATCH/PUT `/api/users/reset_api_key`

You can reset you API key. This invalidates the old one, and generates a new one.

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
    "api_key": "8f15b8b676839c4d293071ae449fa496",
    "api_key_expires_at": "2014-03-21T05:58:12.234Z",
    "email": "name@example.com"
}
```

### PATCH/PUT `/api/users/change_password`

You can change your password.

Request data:

```json
{
    "email": "name@example.com",
    "old_password": "pass1234",
    "new_password": "abcd5678"
}
```

Response:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496",
    "api_key_expires_at": "2014-03-21T05:58:12.234Z",
    "email": "name@example.com"
}
```


### GET `/api/todos`

Get all todos for the current user.

Request data:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496"
}
```

Response:

```json
[
    {
        "id": 20,
        "text": "Pick up the milk.",
        "due_date": "2014-03-03",
        "priority": 3,
        "completed": false,
        "created_at": "2014-02-24T03:14:44.545Z",
        "updated_at": "2014-02-24T03:14:44.545Z",
    }
]
```


### GET `/api/todos/:id`

Get todo with given id.

Request data:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496"
}
```

Response:

```json
{
    "id": 20,
    "text": "Pick up the milk.",
    "due_date": "2014-03-03",
    "priority": 3,
    "completed": false,
    "created_at": "2014-02-24T03:14:44.545Z",
    "updated_at": "2014-02-24T03:14:44.545Z",
}
```


### POST `/api/todos`

Create a new todo.

Request data:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496"
}
```

Response:

```json
{
    "id": 23,
    "completed": false,
    "text": "Finish the app.",
    "due_date": null,
    "priority": 3,
    "created_at": "2014-02-24T03:49:23.410Z",
    "updated_at": "2014-02-24T03:49:23.410Z"
}
```


### PATCH/PUT `/api/todos/:id`

Edit todo with given id.

Note: Only specified fields are updated.
If you want to remove the due date, for example, you must send it as `null`.

Request data:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496",
    "due_date": "2014-02-28T03:00:00.000Z",
    "completed": true
}
```

Response:

```json
{
  "id": 23,
  "completed": true,
  "text": "Finish the app.",
  "due_date": "2014-02-28",
  "priority": 3,
  "created_at": "2014-02-24T03:49:23.410Z",
  "updated_at": "2014-02-24T03:49:23.410Z"
}
```

### DELETE `/api/todos/:id`

Delete todo with given id.

Request data:

```json
{
    "api_key": "8f15b8b676839c4d293071ae449fa496"
}
```

Response: _empty_.
