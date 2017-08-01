class User < ApplicationRecord

  has_many :proposals

  authenticates_with_sorcery!
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name,  presence: true,
                          if: Proc.new { |u| u.user_type === 'dev'}
  validates :org_name, :street_address, :city, :state, :zip, presence: true,
                          if: Proc.new { |u| u.user_type === 'org'}
  validates :website, format: { with: /\A(http:\/\/|https:\/\/)/ , message: "must include http:// or https://" }, allow_blank: true
  validates :ein, format: { with: /\A\d{9}\z/, message: "must be 9 digits (without hyphen)"}, allow_blank: true

  has_many :projects, foreign_key: :organization_id

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
