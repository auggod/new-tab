// Generated by LiveScript 1.3.1
(function(){
  var app;
  app = angular.module('NewTabApp', []);
  app.config(function($compileProvider){
    return $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
  });
  app.directive('colors', function(){
    return {
      restrict: 'A',
      link: function(scope, elem, attrs){
        var colors, index;
        colors = attrs.colors.split(';');
        index = _.random(0, colors.length - 1);
        return elem.css({
          'background': colors[index]
        });
      }
    };
  });
  app.directive('offsetSpace', function(){
    return {
      restrict: 'A',
      link: function(scope, element, attrs){
        return element.css({
          'height': _.parseInt(attrs.offsetSpace) + 'px',
          'display': 'block'
        });
      }
    };
  });
  app.controller('MainCtrl', [
    '$scope', function($scope){
      $scope.form = {};
      chrome.storage.local.get('projects', function(data){
        if (!data) {
          return;
        }
        $scope.projects = data.projects;
        return $scope.$apply();
      });
      $scope.$watchCollection('projects', _.debounce(function(newValue, oldValue){
        if (newValue) {
          $scope.lastProject = _.last($scope.projects);
          chrome.storage.local.set({
            'projects': $scope.projects
          }, function(){
            return console.log('Projects saved');
          });
          return $scope.$apply();
        }
      }, 2000));
      $scope.remove = function(index){
        return $scope.projects.splice(index, 1);
      };
      $scope.addProject = function(){
        if (!$scope.form.title) {
          return;
        }
        if (!$scope.projects) {
          $scope.projects = [];
        }
        return $scope.projects.push({
          date: new Date(),
          title: $scope.form.title,
          url: "https://dev.tracklistapp.com"
        });
      };
    }
  ]);
}).call(this);
