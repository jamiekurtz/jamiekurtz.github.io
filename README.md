This is the [Jekyll](http://jekyllrb.com/)-based source code for my [personal web site](http://www.jamiekurtz.com), which is hosted using GitHub Pages.

It was originally cloned from the Jekyll [Agency bootstrap theme](http://jekyllthemes.org/themes/agency/), but has since evolved quite a bit.


Prerequisites
-------------

This code base uses [Vagrant](https://www.vagrantup.com/) to compile and run the site. This keeps the Ruby runtime and associated Jekyll and other gems off
my laptop, and makes it much easier to work on across machines (and to get the much needed help of others!).

Make sure you have the latest of the following installed:
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


How to use
----------

After cloning this repo, open your terminal to the repo's root, and enter the following:

    vagrant up

This command will download and build an Ubuntu-based virtual machine.

Next, we need to start build and run the site with Jekyll:

1. From your terminal where you ran `vagrant up`, run `vagrant ssh`
1. Once you're in the SSH session, change the current directory to `/vagrant`
1. Then execute `./start`

That last command essentially does this:

    jekyll serve  --host 0.0.0.0 --watch

To stop the VM, enter the following:

    vagrant halt


VM File Sync
------------

In order to ensure the Jekyll file watcher is activated when you change source files, we need to run the following in a
separate terminal:

    vagrant rsync-auto

That command will force a sync between your host and the virtual machine, which will let Jekyll rebuild the site on any
change. If you don't run that command, you will need to stop and restore Jekyll ever time you change a file.

