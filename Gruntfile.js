
/* vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80; */

module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.initConfig({

    coffee: {
      compile: {
        files: {
          'tl-core.js': '*.coffee'
        }
      }
    },

    watch: {
      payload: {
        files: [],
        tasks: []
      }
    }

  });

};
