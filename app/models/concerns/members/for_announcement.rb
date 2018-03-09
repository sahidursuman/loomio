module Members::ForAnnouncement
  def announcement_members(opts = {})
    @announcement_members ||= [
      (Members::Public.new(self) if self.anyone_can_participate),
      (Members::Group.new(self)  if self.group.presence),
      guest_members.with_last_notified_at(self).map { |u| Members::User.new(user) },
      guest_invitations.with_last_notified_at.map   { |i| Members::Invitation.new(invitation) }
    ].flatten.compact
  end
end
