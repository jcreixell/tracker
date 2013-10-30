Tracker
=======

[![Build Status](https://secure.travis-ci.org/jcreixell/tracker.png)](http://travis-ci.org/jcreixell/tracker)
[![Code Climate](https://codeclimate.com/github/jcreixell/tracker.png)](https://codeclimate.com/github/jcreixell/tracker)

Tracker is a service for tracking custom events from Rails applications.

Each Rails application has its own Project, connected by an API key.
Events are generated on the client and delivered to the server for storage and processing. 

Setup
-----

    git clone git://github.com/jcreixell/tracker.git
    cd tracker

Requirements
------------

* MongoDB
* RabbitMQ

Deploy
------

Deploy Tracker like any other Rails app. Heroku example:

    heroku create
    heroku addons:add mongohq:sandbox # Enable MongoHQ addon
    git push heroku master


Create a Project
----------------

Use the following rake task:

    bundle exec rake projects:create[project_name]

(Note: you might need to use quotes if you are in zsh)


Contribute
----------

Set up dependencies:

    bundle

Run the test suite:

    rake

Run the server:

    foreman start


License
-------

Tracker is free software, and may be redistributed under the terms
specified in the MIT-LICENSE file.
