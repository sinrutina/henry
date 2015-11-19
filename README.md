# Henry

A Ruby script for provisioning a server in honor to Henry Ford.

It's like the assembly line manufacturing process but for virtual servers.

## Why

* I don't like Chef, it's too complex.
* I just needed some bash script to be executed on the server and some conf files copied.
* I didn't want big gem that also created the servers.

## Usage

Until I develop a cli command, the current usage is ruby

`ruby assembly-line user@server`

For example to install mongodb:

`ruby mongodb ubuntu@192.156.164.1`

To install ruby with passenger server and nginx

`ruby passenger ubuntu@192.156.164.1`

## Assembly lines

Currently I created assembly lines for:

* mongodb
* redis
* passenger for a Rails app (includes ruby 2.1.5 and nodejs)

You can fork and modify the scripts so it suits you best.
