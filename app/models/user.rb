class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name,  presence: true,
                          if: Proc.new { |u| u.user_type === 'dev'}
  validates :org_name, :street_address, :city, :state, :zip, presence: true,
                          if: Proc.new { |u| u.user_type === 'org'}
end
