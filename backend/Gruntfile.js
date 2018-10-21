module.exports = function(grunt) {
  "use strict";

  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);

  process.env.JS_PATH = process.env.JS_PATH || "http://localhost:8080/app.js";
  process.env.CSS_PATH = process.env.CSS_PATH || "/assets/css/dummy.css";

  grunt.initConfig({
    ts: {
      app: {
        tsconfig: true
      }
    },
    tslint: {
      options: {
        configuration: "tslint.json"
      },
      files: {
        src: ["src/**/*.ts"]
      }
    },
    express: {
      dev: {
        options: {
          script: "./dist/server.js"
        }
      }
    },
    watch: {
      backend: {
        files: ["src/**/*.ts"],
        tasks: ["ts", "tslint"]
      },
      express: {
        files: ["dist/**/*.js"],
        tasks: ["express"],
        options: {
          spawn: false
        }
      }
    },
  });

  grunt.registerTask("develop", ["tslint", "ts", "express", "watch"]);

  grunt.registerTask("build", [
    "tslint",
    "ts"
  ]);

};