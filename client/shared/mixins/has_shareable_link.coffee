LmoUrlService = require 'shared/services/lmo_url_service.coffee'

module.exports = new class HasShareableLink
  apply: (model, opts = {}) ->
    model.constructor.shareable = true

    model.shareableLink = model.shareableLink or ->
      LmoUrlService[model.constructor.singular](model, {}, absolute: true)

    model.makeShareable = ->
      model.anyoneCanParticipate = true
      model.save()

    model.revokeShareable = ->
      model.anyoneCanParticipate = false
      model.save()

    model.alwaysShareable = opts.alwaysShareable
    model.anyoneCanParticipate = true if model.alwaysShareable
    model.shareableApplied = true
