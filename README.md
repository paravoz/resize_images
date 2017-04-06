# README

ResizeImages is a simple API allowing to upload and resize images.

### System dependencies

Before running the ResizeImages API, you need to install:

* The Ruby language version 2.4
* MongoDB version 3.4

Check that appropriate versions of Ruby and MongoDB are installed in your development environment:
```
$ ruby -v
$ mongo
```
* Install Ruby - https://www.ruby-lang.org/en/documentation/installation/
* Install MongoDB - https://docs.mongodb.com/manual/installation/

### Up and running application

##### Initialize application

```
git clone git@github.com:paravoz/resize_images.git
cd resize_images
bundle install
```

##### Configuration MongoDB

Mongoid configuration can be done through a mongoid.yml that specifies your options and clients. The simplest configuration is as follows, which sets the default client to “localhost:27017” and provides a single database in that client named “mongoid”.

```yaml
development:
  clients:
    default:
      database: mongoid
      hosts:
        - localhost:27017
```
You can generate a config file by executing the generator and then editing myapp/config/mongoid.yml to your heart’s desire
```
$ rails generate mongoid:config
```

##### Run API server

```
bin/rails server
```

### Generate the docs

```
$ rake docs:generate
```

You can view your documentation at the default api/docs route

### Run specs

Use the rspec command to run your specs:

```
bundle exec rspec
```
