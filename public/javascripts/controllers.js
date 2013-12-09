(function() {
  var module = angular.module('app.controllers', []);

  var TodayCtl = function($scope, $http, $timeout) {
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

    // fetch initial results
    $timeout($scope.fetch);
  };

  TodayCtl.$inject = ['$scope', '$http', '$timeout'];

  module.controller('TodayCtl', TodayCtl);
})();
