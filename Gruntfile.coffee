module.exports = (grunt) ->
    REPORTER = 'dot'
    {spawn} = require 'child_process'

    grunt.loadNpmTasks 'grunt-reload'
    grunt.loadNpmTasks 'grunt-mocha'
    grunt.loadNpmTasks 'grunt-simple-mocha'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    outputStdout = (data) ->
        console.log data.toString('utf8').trim()

    output = (proc) ->
        proc.stdout.on 'data', (data) -> outputStdout data
        proc.stderr.on 'data', (data) -> outputStdout data

    grunt.initConfig
        reload:
            port: 6001
            proxy:
                host: 'localhost'
                port: 3000
        watch:
            coffee:
                files: 'public/app/scripts/coffee/**/*.coffee'
                tasks: 'coffee reload'
            reload:
                files: [
                    'public/app/*.html',
                    'public/app/styles/**/*.css',
                    'public/app/scripts/**/*.js',
                    'public/app/images/**/*',
                    'public/app/**/*.html'
                ]
                tasks: 'reload'
        #browser testing through PhantomJS
        mocha:
            all: ['public/test/**/*.html']
            options:
                mocha:
                    ignoreLeaks: false
                    reporter: 'spec'
                run: true
        simplemocha:
            options:
                timeout: 3000
                ignoreLeaks: false
                ui: 'bdd'
                reporter: 'spec'
                compilers: 'coffee:coffee-script'
            all:
                src: 'test/**/*.coffee'

    grunt.registerTask 'supervisor', ->
        output spawn  'nodemon', ['--watch',
            'lib',
            '--watch',
            'routes',
            '--watch',
            'app.coffee',
            'app.coffee'
        ]

    grunt.registerTask 'debug', ->
        ## go to http://localhost:5801/debug?port=5858 to debug with
        ## node-inspector (you need nodev and node-inspector packages)
        output spawn  'nodev', ['--watch',
            'lib',
            '--watch',
            'routes',
            '--watch',
            'app.coffee',
            'app.coffee'
        ]

    grunt.registerTask 'coffee', ->
        # put your client-side coffee scripts from 
        # public/app/scripts/coffee to
        # public/app/scripts
        output spawn 'coffee', ['--compile', '--output', 'public/app/scripts', 'public/app/scripts/coffee']
        # compile test written in coffee-script
        output spawn 'coffee', ['--compile', '--output', 'public/test/spec', 'public/test/spec/coffee']

    grunt.registerTask 'default', ['server']
    grunt.registerTask 'test', ['coffee', 'simplemocha', 'mocha']
    grunt.registerTask 'server', ['test', 'supervisor', 'reload', 'watch']
    grunt.registerTask 'debug', ['debug', 'reload', 'watch']

