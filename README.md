# My Wine Cellar | The API
by [Matthew Yang](http://matthewgyang.com)

[![Build Status](https://travis-ci.org/yang70/wine_api.svg?branch=master)](https://travis-ci.org/yang70/wine_api)
[![Coverage Status](https://coveralls.io/repos/github/yang70/wine_api/badge.svg?branch=master)](https://coveralls.io/github/yang70/wine_api?branch=master)

This application (still in progress) is a personal pet-project that I am developing to enhance both my front and back end development skills.  It is a [Ruby on Rails](http://rubyonrails.org/) API that allows the user to track the inventory of their wine cellar (additional features to be added).  I plan on connecting to this API by developing several JavaScript SPA's using [React](https://facebook.github.io/react/), [AngularJS](https://angularjs.org/) and [EmberJS](http://emberjs.com/).

## Technology Used

__This application incorporates the following technologies:__

* [Rails API](https://github.com/rails-api/rails-api)
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers)
* [JWT Gem](https://rubygems.org/gems/jwt/versions/1.5.4)
* [Devise](https://github.com/plataformatec/devise)
* [CanCanCan](https://github.com/CanCanCommunity/cancancan)
* [Rack-cors Gem](https://rubygems.org/gems/rack-cors/versions/0.4.0)

__Testing:__

* [RSPEC](http://rspec.info/)
* [Factory Girl](https://github.com/thoughtbot/factory_girl_rails)

__Deployment:__

* [Heroku](https://dashboard.heroku.com/)
* [TravisCI](https://travis-ci.org/)

## Use | Command Line Examples

### Sign In
Send a `POST` request including the email and password:

```bash
$ curl -X POST -d email=youremail@example.com -d password=password http://my-wine-cellar.herokuapp.com/auth_user
```

This will return a JSON object with a JWT token and user information:

```json
{
  "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjgzODU2Njh9.2F9svbuY43OVckAfyfxeD3kKk7b0Y4k3YHWWUac7cNw",
  "user": {
    "id": 1,
    "email": "youremail@example.com"
  }
}
```
### Get List of User's Wine
Send a `GET` request with the JWT in the header:

```bash
$ curl -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjgzODU2Njh9.2F9svbuY43OVckAfyfxeD3kKk7b0Y4k3YHWWUac7cNw' http://my-wine-cellar.herokuapp.com/wines
```
This will return an array of JSON object's of the users wine

```json
[
  {
    "id": 1,
    "name": "User's Wine 1",
    "varietal": "Cabernet Sauvignon",
    "quantity": 1,
    "user": {
      "id": 1,
      "email": "youremail@example.com",
      "created_at": "2016-05-19T20:59:38.601Z",
      "updated_at": "2016-05-19T20:59:38.601Z"
    }
  },
  {
    "id": 2,
    "name": "User's Wine 2",
    "varietal": "Syrah",
    "quantity": 1,
    "user": {
      "id": 1,
      "email": "youremail@example.com",
      "created_at": "2016-05-19T20:59:38.601Z",
      "updated_at": "2016-05-19T20:59:38.601Z"
    }
  }
]
```
### Get Info On A Specific Wine
Send a `GET` request to a specific wine's ID:

```bash
$ curl -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjgzODU2Njh9.2F9svbuY43OVckAfyfxeD3kKk7b0Y4k3YHWWUac7cNw' http://my-wine-cellar.herokuapp.com/wines/1
```

This will return a JSON object with info on that wine:

```json
{
  "id": 1,
  "name": "User's Wine 1",
  "varietal": "Cabernet Sauvignon",
  "quantity": 1 
  "user": {
    "id": 1,
    "email": "youremail@example.com",
    "created_at": "2016-05-19T20:59:38.601Z",
    "updated_at": "2016-05-19T20:59:38.601Z"
  }
}
```
___
Questions?  [matt@matthewgyang.com](mailto:matt@matthewgyang.com)