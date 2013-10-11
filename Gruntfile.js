
/* vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80; */

module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.initConfig({

    coffee: {
      compile: {
        files: {
          'timelight-core.js': 'lib/*.coffee'
        }
      }
    }

  });

};
