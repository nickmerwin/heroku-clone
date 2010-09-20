# Heroku Clone

Will clone a Heroku app to a new app. Will clone the following:

  * Code
  * Addons
  * Config Vars
  * Collaborators

## Installation

    $ heroku plugins:install git://github.com/ddollar/heroku-clone.git

## Usage

    $ heroku clone --app example-app

    Cloning example-app
      * creating application
        * new app: fierce-autumn-86
      * cloning addons
        * installing cron:hourly
        * installing memcache:5mb
        * installing newrelic:bronze
      * cloning configuration
        * DATABASE_URL
        * MEMCACHE_PASSWORD
        * MEMCACHE_SERVERS
        * MEMCACHE_USERNAME
        * NEW_RELIC_APPNAME
        * NEW_RELIC_ID
        * NEW_RELIC_LICENSE_KEY
        * RACK_ENV
      * cloning repository
    remote: Counting objects: 423, done.
    remote: Compressing objects: 100% (406/406), done.
    remote: Total 423 (delta 252), reused 0 (delta 0)
    Receiving objects: 100% (423/423), 65.84 KiB, done.
    Resolving deltas: 100% (252/252), done.
    Counting objects: 423, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (154/154), done.
    Writing objects: 100% (423/423), 70.25 KiB, done.
    Total 423 (delta 252), reused 423 (delta 252)

    -----> Heroku receiving push
    -----> Sinatra app detected
    -----> Gemfile detected, running Bundler version 1.0.0
           Unresolved dependencies detected; Installing...
           Fetching source index for http://rubygems.org/
           Installing rake (0.8.7) 
           Installing mime-types (1.16) 
           Installing crack (0.1.8) 
           Installing daemons (1.1.0) 
           Installing eventmachine (0.12.10) with native extensions 
           Installing haml (3.0.16) 
           Installing rack (1.2.1) 
           Installing shotgun (0.8) 
           Installing sinatra (1.0) 
           Installing thin (1.2.7) with native extensions 

           Using bundler (1.0.0) 
           Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
       
           Your bundle was installed to `.bundle/gems`
    -----> Configuring New Relic plugin... done.
           Not a Rails app, can't install New Relic plugin.
           Compiled slug size is 3.4MB
    -----> Launching.... done
    -----> Running New Relic deploy notification... done

           http://fierce-autumn-86.heroku.com deployed to Heroku

    To git@heroku.com:fierce-autumn-86.git
     * [new branch]      master -> master
      * cloning collaborators
        * adding david@heroku.com