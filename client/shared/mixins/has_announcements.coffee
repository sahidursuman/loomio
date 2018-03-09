module.exports = new class HasAnnouncements
  apply: (model, opts = {}) ->
    model.announcements = ->
      model.recordStore.announcements.find model.announcementIds

    model.announcementRecipients = ->
      model.announcementUsers().concat model.announcementInvitations()

    model.announcementUsers = ->
      model.recordStore.users.find _.flatten _.pluck @announcements(), 'userIds'

    model.announcementInvitations = ->
      model.recordStore.invitations.find _.flatten _.pluck @announcements(), 'invitationIds'

    model.announcementsApplied = true
