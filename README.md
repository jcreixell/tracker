Tracker
=======

[![Build Status](https://secure.travis-ci.org/jcreixell/tracker.png)](http://travis-ci.org/jcreixell/tracker)

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
    git push heroku master

(Note: you will need to properly configure MongoDB and RabbitMQ)


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

Copycopter Server is free software, and may be redistributed under the terms
specified in the MIT-LICENSE file.
