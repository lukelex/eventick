# Eventick

[![Gem Version](https://badge.fury.io/rb/eventick_api.png)](http://badge.fury.io/rb/eventick_api)
[![Build Status](https://travis-ci.org/lukelex/eventick_api.png?branch=master)](https://travis-ci.org/lukelex/eventick_api)
[![Code Climate](https://codeclimate.com/github/lukelex/eventick_api.png)](https://codeclimate.com/github/lukelex/eventick_api)

Eventick is a simple API wrapper public Eventick API.

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'eventick_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventick_api

###Rails
If you are using Rails you should create an initializer, *eventick_api.rb* in <rails_app_folder>/config/initializers.

	require 'eventick'

## Usage

**Getting Token**

	auth = Eventick::Auth.new

	auth.email = email
	auth.password = password

	auth.token



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
