(function() {
  var module = angular.module('app.controllers', []);

  var TodayCtl = function($scope, $http, $timeout, $interval) {
    // loads more entries
    $scope.fetch = function() {
      var query = $http.get('/today.json', {
        params: { offset: $scope.offset }
      });

      $scope.loading = true;

      query.success(function(data, status) {
        $scope.more    = (data.length == $scope.limit);
        $scope.offset  = $scope.offset + $scope.limit;
        $scope.loading = false;
        $scope.rows    = $scope.rows.concat(data);
      });

      query.error(function(data, status) {
        console.error(status, data);
        $scope.loading = false;
        // TODO: notify
      });
    }

    // setup the scope's initial state
    $scope.rows    = [];
    $scope.loading = false;
    $scope.more    = true;
    $scope.offset  = 0;
    $scope.limit   = 100;

    $scope.date    = new Date();
    $scope.expired = false;

    // fetch initial results
    $timeout($scope.fetch);

    // check whether date still is "today"
    $interval(function() {
      var now = new Date(),
          d = $scope.date;
      $scope.expired =
        (d.getDate() != now.getDate()) ||
        (d.getMonth() != now.getMonth());
    }, 1000);
  };

  TodayCtl.$inject = ['$scope', '$http', '$timeout', '$interval'];

  module.controller('TodayCtl', TodayCtl);
})();
