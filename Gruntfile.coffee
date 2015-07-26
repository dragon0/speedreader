module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            app:
                options:
                    join: true
                files:
                    'dest/www/js/index.js': [
                        'src/coffee/index.coffee'
                    ]
            test:
                options:
                    join: true
                files:
                    'dest/test/js/test.js': [
                        'test/coffee/test.coffee'
                    ]
        qunit:
            all: ['dest/test/test.html']
        copy:
            js_lib:
                expand: true
                src: [
                    'node_modules/jquery/dist/jquery.min.js',
                    'node_modules/bootstrap/dist/js/bootstrap.min.js'
                    ]
                dest: 'dest/www/js/lib/'
                flatten: true
            css_lib:
                expand: true
                src: [
                    'node_modules/bootstrap/dist/css/bootstrap.min.css'
                    ]
                dest: 'dest/www/css/lib/'
                flatten: true
            js_lib_test:
                expand: true
                src: [
                    'node_modules/jquery/dist/jquery.min.js',
                    'node_modules/bootstrap/dist/js/bootstrap.min.js'
                    ]
                dest: 'dest/test/js/lib/'
                flatten: true
            css_lib_test:
                expand: true
                src: [
                    'node_modules/bootstrap/dist/css/bootstrap.min.css'
                    ]
                dest: 'dest/test/css/lib/'
                flatten: true
            assets:
                expand: true
                cwd: 'assets'
                src: '**'
                dest: 'dest/www/'
            app:
                expand: true
                cwd: 'src'
                src: '**/*.html'
                dest: 'dest/www/'
            test:
                expand: true
                cwd: 'test'
                src: '**/*.html'
                dest: 'dest/test/'
            test_assets:
                expand: true
                cwd: 'assets'
                src: '**'
                dest: 'dest/test/'
            qunit_js:
                expand: true
                src: 'node_modules/qunitjs/qunit/qunit.js'
                dest: 'dest/test/js/lib/'
                flatten: true
            qunit_css:
                expand: true
                src: 'node_modules/qunitjs/qunit/qunit.css'
                dest: 'dest/test/css/'
                flatten: true

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-qunit'
    grunt.loadNpmTasks 'grunt-contrib-copy'

    grunt.registerTask 'copy_app', [
        'copy:app',
        'copy:assets',
        'copy:js_lib',
        'copy:css_lib'
    ]
    grunt.registerTask 'copy_test', [
        'copy:test',
        'copy:test_assets',
        'copy:js_lib_test',
        'copy:css_lib_test',
        'copy:qunit_js',
        'copy:qunit_css'
    ]
    grunt.registerTask 'test', ['coffee:test', 'copy_test', 'qunit:all']
    grunt.registerTask 'default', ['coffee:app', 'copy_app']


