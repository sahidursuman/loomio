Session = require 'shared/services/session.coffee'
Records = require 'shared/services/records.coffee'

{ listenForLoading } = require 'angular/helpers/listen.coffee'
{ myLastStanceFor }  = require 'angular/helpers/poll.coffee'

angular.module('loomioApp').directive 'pollCommonCard', ->
  scope: {poll: '='}
  templateUrl: 'generated/components/poll/common/card/poll_common_card.html'
  replace: true
  controller: ($scope) ->
    Records.polls.findOrFetchById($scope.poll.key) unless $scope.poll.complete

    $scope.buttonPressed = false
    $scope.$on 'showResults', ->
      $scope.buttonPressed = true

    $scope.showResults = ->
      $scope.buttonPressed || myLastStanceFor($scope.poll)? || $scope.poll.isClosed()

    $scope.$on 'stanceSaved', ->
      $scope.$broadcast 'refreshStance'

    listenForLoading $scope
