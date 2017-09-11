class User < ApplicationRecord
  dragonfly_accessor :image
  has_many :proposals
  has_many :projects, foreign_key: :organization_id
  authenticates_with_sorcery!

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

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

  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false, message: 'must be .jpeg, .jpg, .png, .bmp format', if: :image_changed?

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
