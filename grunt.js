module.exports = function(grunt) {

	grunt.loadNpmTasks('grunt-bg-shell');
	grunt.loadNpmTasks('grunt-reload');

	// Project configuration.
	grunt.initConfig({
		pkg: '<json:package.json>',
		test: {
			files: ['test/**/*.js']
		},
		lint: {
			files: [
				'grunt.js',
				'app.js', 
				'routes/**/*.js',
				'lib/**/*.js',
				'test/**/*.js',
				'public/app/scripts/**/*.js',
				'public/spec/**/*.js'
				]
		},
		bgShell: {
			supervisor: {
				cmd: 'node-dev app.js',
				stdout: true,
				stderr: true,
				bg: true
			},
			debug: {
				cmd: 'node-dev --debug app.js',
				stdout: true,
				stderr: true,
				bg: false
			},
			"debug-brk": {
				cmd: 'node-dev app.js --start-brk app.js',
				stdout: true,
				stderr: true,
				bg: false
			},
			inspector: {
				cmd: 'node-inspector',
				stdout: true,
				stderr: true,
				bg: false
			}
		},
		reload: {
			port: 6001,
			proxy: {
				host: 'localhost',
				port: 3000
			},
		},
		watch: {
			files: [
				//add here static file which need to be livereloaded
				'public/app/*.html',
				'public/app/styles/**/*.css',
				'public/app/scripts/**/*.js',
				'public/app/images/**/*',
				'public/app/**/*.html'
				],
			tasks: 'reload'
		},
		jshint: {
			options: {
				curly: true,
				eqeqeq: true,
				immed: true,
				latedef: true,
				newcap: true,
				noarg: true,
				sub: true,
				undef: true,
				boss: true,
				eqnull: true,
				node: true
			},
			globals: {
				exports: true
			}
		}
	});

	// Default task.
	grunt.registerTask('default', 'lint test server');
	grunt.registerTask('server', 'bgShell:supervisor reload watch');
	grunt.registerTask('debug', 'bgShell:debug bgShell:inspector');
	grunt.registerTask('debug-brk', 'bgShell:debug-brk bgShell:inspector');

};
