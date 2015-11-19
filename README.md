# Henry

A Ruby script for provisioning a server in honor to Henry Ford.

It's like the assembly line manufacturing process but for virtual servers.

![Assembly Line](http://i.imgur.com/5Ja7hW9.jpg)

## Why

* I don't like Chef, it's too complex.
* I just needed some bash script to be executed on the server and some conf files copied.
* I didn't want big gem that also created the servers.
* I didn't need it to be a deployment tool.

## Usage

Until I develop a cli command, the current usage is ruby

```bash
 $ ruby henry.rb assembly-line user@server
```

For example to install mongodb:

```bash
$ ruby henry.rb mongodb ubuntu@192.168.33.10
```

To install ruby with passenger server and nginx

```bash
 $ ruby henry.rb passenger ubuntu@192.168.33.10
```

## Assembly lines

Currently I created assembly lines for:

* mongodb
* redis
* passenger for a Rails app (includes ruby 2.1.5 and nodejs)

You can fork and modify the scripts so it suits you best.

## Test

You can test your configuration and new assembly lines in the vagrant server that is provided here.

Just run:

```bash
$ vagrant up
$ ruby henry.rb passenger vagrant@192.168.33.10
```

Test it and then.
```bash
$ vagrant destroy
```

More info about vagrant here: https://www.vagrantup.com/

## Inspiration

I was heavily inspired but this awesome tool called Sunzi https://github.com/kenn/sunzi

