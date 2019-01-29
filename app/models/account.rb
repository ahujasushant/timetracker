class Account < ApplicationRecord
  RESTRICTED_SUBDOMAINS = %w[www]

  belongs_to :owner, class_name: 'User'

  validates_presence_of :owner
  validates :subdomain, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\-]+\z/i, message: 'conatins invalid characters' },
                        exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }

  accepts_nested_attributes_for :owner
  before_validation :downcase_subddomain

  private

  def downcase_subddomain
    self.subdomain = subdomain.try(:downcase)
  end
end
