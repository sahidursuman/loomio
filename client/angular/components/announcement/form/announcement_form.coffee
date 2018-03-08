Records      = require 'shared/services/records.coffee'
ModalService = require 'shared/services/modal_service.coffee'
I18n         = require 'shared/services/i18n.coffee'

angular.module('loomioApp').directive 'announcementForm', ->
  scope: {announcement: '='}
  restrict: 'E'
  templateUrl: 'generated/components/announcement/form/announcement_form.html'
  controller: ['$scope', ($scope) ->
    $scope.$emit 'processing'
    Records.announcements.fetchNotifiedDefault($scope.announcement.eventForNotifiedDefault()).then (notified) ->
      $scope.announcement.notified = notified if _.any(notified)
    .finally ->
      $scope.$emit 'doneProcessing'

    Records.members.collection.chain().remove()

    $scope.acceptChip = ($chip) ->
      $chip.subtitle = I18n.t('announcement.form.click_to_edit') if $chip.type == 'Group'
      if $chip.type != 'Null' then $chip else null

    $scope.inviteToDiscussion = ->
      ModalService.open 'AnnouncementModal', announcement: ->
        Records.announcements.buildFromModel($scope.relevantDiscussion())

    $scope.relevantDiscussion = ->
      return if $scope.announcement.modelName() == 'discussion'
      $scope.announcement.model().discussion()

    $scope.search = (query) ->
      Records.announcements.fetchNotified(query)
  ]
