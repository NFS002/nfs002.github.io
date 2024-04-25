---
layout: post
categories: posts
title: "Auth templates"
tags: [ golang api auth programming ]
date-string: 25th April 2024
---

## Simple golang auth templates

This post is somehwat similar to the [kefei](https://nfs002.github.io/posts/2023-01-09/kefei.html) post in that is was motivated by a very common developer process that I felt was unecessarilly complicated. However, in this case, that process was not a database connection, but protecting your API.

#### There are a number of ways you might choose to do this, and two common choices, for which I have written application 
#### templates for are:
##### - Oauth 2.0 ([template-v2]())
##### - Simple Token authentication ([template-v1]())

### [OAuth 2.0](https://github.com/NFS002/go-template-v2)
OAuth 2.0 is in essence not an authorisation protocol, but actually a delegation protocol, that delegates authenticating a user with your service to another service (typically Facebook, Google, Twitter, Github).
OAuth 2.0 is widly regarded as one of the highest security standards, and the main benefits from a user perspective is increased security, as you never have to create or share any credentials for or with the service you are trying to access.

Previously, when I have wanted to set up OAuth2.0 on an app, it has been a fiddly process to say the least, and Im sure others had a similar experience. While OAuth 2.0 provides a strong foundation for secure authorization, the overall security of any system utilizing OAuth 2.0 depends on the implementation and the surrounding security measures.

Therefore, to both consolidate my own knowledge and provoide a useful starting point to others, I have written this application template with the following features.

- Simple REST API using the popular [gin](https://github.com/gin-gonic/gin) framework for golang.

- OAuth2.0 authentication provided by Auth0
    - Obviously this requires you to setup an account on Auth0, akthough I was able to setup a free one which allowed me to generate up to 1000 tokens a month, 
    - Token providers:
        - Google 
        - Apple
        - Facebook
        - (Username, email) DB

- All endpoints */api/(host|exhibition|host|user)* require JWT authentication 

- Additionally, the GET /api/host endpoint requires a token with the `read:host` permission.

*More information, including my particular Auth0 Account setup, is given in the [repository README](https://github.com/nfs002/go-template-v2)*

### [Simple token authentication](https://github.com/NFS002/go-template-v1)


Another relatively simple golang API server application template:

- An HTTP server using JSON over REST
- API token authentication with scoped tokens
- Each endpoint can be configured to require a given scope
- A user can request a token with a given scope with their username/email and password
    - The token is only granted if the user's scope encompasses the requested token scope
- Lazy expired token cleanup
    - When a request is sent using an expired token, the token is deleted from the database
- When the app starts, it looks for an environemnt variable `APP_ENV`
    - `$APP_ENV` must be set manually *before* running the app
        - e.g `APP_ENV=dev go run .`
        - As opposed to other environment variables, which are loaded on app startup by [godotenv](https://github.com/joho/godotenv)
    - If this is set, it attempts to load the environment variables in the file `.env.${APP_ENV}`
        - If file does not exist, it attempts to load the environment variables in the default file `.env`
    - If this is not set, it attempts to load the environment variables in the default file `.env`
    - Connection to the db instance from the app is set via the `$POSTGRESQL_URL` environment variable
- Database migrtations managed by the [golang-migrate](https://github.com/golang-migrate/migrate) module
    - All up migrations are run on startup if `RUN_MIGRAGTIONS=true`
- [Zerolog](https://github.com/rs/zerolog) for structured JSON logging
- Tokens and users persisted in a postgresql database
    - Passwords are hashed and salted using bcrypt before persisting
    - Tokens are hashed using SHA-256 before persisting
- Request validation using the [github.com/go-playground/validator/v10](https://github.com/go-playground/validator) module
- Postgresql db intstance runs in a docker container
    - start with `docker-compose up`

*More information is given in the [repository README](https://github.com/nfs002/go-template-v2)*

##### Hopefully, at least one of these templates were helpful to someone, but if not, they were still fun to make :)


