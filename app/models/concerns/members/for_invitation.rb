module Members::ForInvitation
  def announcement_members(opts = {})
    @announcement_members ||= [
      members.with_joined_at(self).map      { |u| Members::User.new(u) },
      invitations.with_last_notified_at.map { |i| Members::Invitation.new(i) }
    ].flatten.compact
  end
end
