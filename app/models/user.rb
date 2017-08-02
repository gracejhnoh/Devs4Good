class User < ApplicationRecord

  has_many :proposals

  authenticates_with_sorcery!
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :first_name, :last_name,  presence: true,
                          if: Proc.new { |u| u.user_type === 'dev'}
  validates :org_name, :street_address, :city, presence: true,
                          if: Proc.new { |u| u.user_type === 'org'}
  validates :state, presence: true, format: { with: /\A[A-Z]{2}\z/, message: "must be two capital letters (e.g. WA)"},
                          if: Proc.new { |u| u.user_type === 'org'}
  validates :zip, presence: true, format: { with: /\A\d{5}\z/, message: "must be 5 digits" },
                          if: Proc.new { |u| u.user_type === 'org'}
  validates :website, format: { with: /\A(http:\/\/|https:\/\/)/ , message: "must include http:// or https://" }, allow_blank: true
  validates :phone, format: { with: /\A\d{3}-\d{3}-\d{4}\z/ , message: "must be in XXX-XXX-XXXX format"}, allow_blank: true
  validates :ein, format: { with: /\A\d{9}\z/, message: "must be 9 digits (without hyphen)"}, allow_blank: true

  has_many :projects, foreign_key: :organization_id

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
