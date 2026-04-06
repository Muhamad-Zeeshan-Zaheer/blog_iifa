class Comment < ApplicationRecord
  include Visible
  belongs_to :article
  after_create_commit :broadcast_comment

  private

  def broadcast_comment
    ActionCable.server.broadcast(
      "comments_#{article_id}",
      {
        title: title,
        body: body,
        user: user.name,
        created_at: created_at.strftime("%H:%M")
      }
    )
  end
end
