app = angular.module 'NewTabApp', []

app.config ($compileProvider) ->

  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/)

app.directive 'colors', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    colors = attrs.colors.split(';')
    index = _.random(0, colors.length - 1)
    elem.css 'background': colors[index]

app.directive 'offsetSpace', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.css do
      'height': _.parseInt(attrs.offsetSpace) + 'px'
      'display': 'block'

app.controller 'MainCtrl', ['$scope' ($scope) !->

  $scope.form = {}

  chrome.storage.local.get 'projects', (data) ->
    unless data
      return
    $scope.projects = data.projects

    $scope.$apply!

  $scope.$watchCollection 'projects', _.debounce((newValue, oldValue) ->
    if newValue
      $scope.lastProject = _.last($scope.projects)

      chrome.storage.local.set 'projects': $scope.projects, ->
        console.log 'Projects saved'

      $scope.$apply!
  , 2000)

  $scope.remove = (index) ->
    $scope.projects.splice(index, 1)

  $scope.addProject = ->

    if not $scope.form.title
      return

    if not $scope.projects
      $scope.projects = []

    $scope.projects.push({
      date: new Date!
      title: $scope.form.title
      url: "https://dev.tracklistapp.com"
    })

]
