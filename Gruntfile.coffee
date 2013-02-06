module.exports = (grunt) ->
    REPORTER = 'dot'
    {spawn} = require 'child_process'

    grunt.loadNpmTasks 'grunt-reload'
    grunt.loadNpmTasks 'grunt-regarde'
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
            tests:
                files: ['test/**/*.coffee', 'lib/**/*.coffee', 'app.coffee']
                tasks: ['simplemocha']
        regarde:
            app:
                files: [
                    'public/app/*.html',
                    'public/app/styles/**/*.css',
                    'public/app/scripts/**/*.js',
                    'public/app/images/**/*',
                    'public/app/**/*.html',

                    'public/app/coffee/**/*.coffee',
                    'public/test/spec/coffee/**/*.coffee'
                ]
                #tasks: ['coffee:compile', 'reload']
                tasks: 'regarde:trigger'
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
        output spawn  'nodemon', [
            '--watch',
            'lib',
            '--watch',
            'app.coffee',
            'app.coffee'
        ]

    grunt.registerTask 'nodev', ->
        ## go to http://localhost:5801/debug?port=5858 to debug with
        ## node-inspector (you need nodev and node-inspector packages)
        output spawn  'nodev', [
            '--watch',
            'lib',
            '--watch',
            'app.coffee',
            'app.coffee'
        ]

    grunt.registerTask 'regarde:trigger', () ->
        grunt.regarde.changed.forEach (file) ->
            console.log file
            if file.indexOf('.coffee') isnt -1
                grunt.task.run 'coffee:compile'
            else
                grunt.task.run 'reload'


    # compile clien-side coffee scripts(application and tests)
    grunt.registerTask 'coffee:compile', ->
        output spawn 'coffee', ['--compile', '--output', 'public/app/scripts/', 'public/app/coffee/']
        output spawn 'coffee', ['--compile', '--output', 'public/test/spec/', 'public/test/spec/coffee/']

    grunt.registerTask 'env:test', ->
        process.env.NODE_ENV = 'test'
    grunt.registerTask 'env:dev', ->
        process.env.NODE_ENV = 'development'

    grunt.registerTask 'test', ['env:test', 'simplemocha']
    grunt.registerTask 'test:watch', ['env:test', 'simplemocha', 'watch:tests']
    grunt.registerTask 'debug', ['env:dev','nodev']
    grunt.registerTask 'default', ['server']
    grunt.registerTask 'server', ['env:dev', 'test', 'coffee:compile', 'supervisor', 'reload', 'regarde:app']

