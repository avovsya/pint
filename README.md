# PINT

Template for Node.js SPAs using Express and Yeoman(or something else with folder structure like in Yeoman)

## Getting Started

1. Download [archive](https://github.com/avovsya/pint/archive/master.zip) and unzip
2. Run *npm install* command
3. Initialize Yeoman in public/ directory
4. Put you routes in app.coffee(or anywhere else, but don't forget to require in app.coffee)
5. Put you server-side tests written using Mocha in test/ directory
6. Put you client-side tests(also Mocha) in public/test/
7. Run *grunt* command and voilà - you've got server with autoreload server-side and client-side(livereload) scripts 

## Prerequisites

### Global packages, that should be installed:
+ grunt-cli
+ nodemon
+ coffee-script
+ node-inspector
+ nodev (for easily debugging with node-inspector)
+ PhantomJS (not a node package)

## What's include

### Grunt tasks
+ server - will watch your server-side code and restart server on changes. Also watches you client side html,css,js(coffee) and LiveReloads it. Go to localhost:6001 and check it out.
+ debug - run node server in debug mode and also run node-inspector
+ test - run your server-side tests and client-side tests(using PhantomJS)

## Notes

### Coffee-script 
You can write your client-side code(and tests) in coffee-script. Simply put
scripts in public/app/scripts/coffee and public/test/spec/coffee and they will
be automatically compiled to public/app/scripts and public/test/spec
respectively. Folder structure will be saved. 

### Testing
To execute your tests run *grunt test* command(it also automatically runs on
*grunt server*). Grunt will execute all server-side(test/\*.coffee) and
client-side (public/test/index.html) tests. Unfortunately *grunt-mocha* plugin
which is used to run client-side test without browser(using PhantomJS) have unpredictable behavior(wrong test can pass, and this depends in order in which tests been executed). You better test your code by opening
public/test/index.html in browser(and this is much more beautiful, thanks to
Mocha =). I'm working on fixing this.



## License
Copyright (c) 2013 Artem Vovsya  
Licensed under the MIT license.
