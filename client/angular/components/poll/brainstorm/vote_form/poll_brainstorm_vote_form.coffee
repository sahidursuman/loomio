AppConfig = require 'shared/services/app_config.coffee'
Records   = require 'shared/services/records.coffee'

{ submitStance }     = require 'shared/helpers/form.coffee'
{ registerKeyEvent } = require 'shared/helpers/keyboard.coffee'

angular.module('loomioApp').directive 'pollBrainstormVoteForm', ->
  scope: {stance: '='}
  templateUrl: 'generated/components/poll/brainstorm/vote_form/poll_brainstorm_vote_form.html'
  controller: ['$scope', ($scope) ->
    $scope.pollOptionNames = _.pluck $scope.stance.pollOptions(), 'name'

    $scope.submit = submitStance $scope, $scope.stance,
      prepareFn: (optionName) ->
        $scope.stance.choice = _.compact $scope.pollOptionNames
        $scope.$emit 'processing'

    $scope.addOption = ->
      return unless ($scope.newOptionName or "").length
      $scope.pollOptionNames.push $scope.newOptionName
      $scope.newOptionName = ""

    $scope.removeOption = (name) ->
      _.pull $scope.pollOptionNames, name

    registerKeyEvent $scope, 'pressedEnter', $scope.addOption, (active) ->
      active.classList.contains('poll-brainstorm-vote-form__input')
  ]
