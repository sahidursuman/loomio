FlashService  = require 'shared/services/flash_service.coffee'

angular.module('loomioApp').directive 'announcementShareableLink', ->
  scope: {model: '='}
  restrict: 'E'
  templateUrl: 'generated/components/announcement/shareable_link/announcement_shareable_link.html'
  controller: ['$scope', ($scope) ->
    $scope.copied = ->
      FlashService.success('common.copied')
  ]
