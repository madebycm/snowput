'use strict';

angular.module('dummyApp')
  .controller('MainCtrl', function ($scope, $http) {
  	var url = "http://localhost:4567/";

    var conf = {
      headers: {
        "X-Snowput-Auth": "_dev",
      }
    }

    var data = {
      languages: 
        ["Ruby", "Javascript"],
      frameworks:
        ["AngularJS", "Sinatra"],
      database: "MongoDB"
    }

    $http.post(url+"technologies", data, conf).success(function(d){
      $scope.snowput = json(d);
    }).error(function(d){
      $scope.snowput = json(d);
    });

  	var json = function(input){
  		return JSON.stringify(input, null, 4);
  	}

  });