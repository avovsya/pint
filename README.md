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
+ server - will watch your server-side code and restart server on changes. Also watches you client side html,css,js(coffee) and LiveReloads it
+ debug - run node server in debug mode and also run node-inspector
+ test - run your server-side tests and client-side tests(using PhantomJS)


## License
Copyright (c) 2013 Artem Vovsya  
Licensed under the MIT license.
