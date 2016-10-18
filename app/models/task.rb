class Task < ApplicationRecord
  enum state: [:todo, :doing, :done]
  belongs_to :user

  validates :content, :user_id, presence: true
  include AutoHtml

  FORMAT = AutoHtml::Pipeline.new(
    AutoHtml::HtmlEscape.new,
    AutoHtml::Markdown.new
  )

  def content=(t)
    super(t)
    self[:content_html] = FORMAT.call(t)
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :content,
      [:content, :created_at]    ]
  end
end
