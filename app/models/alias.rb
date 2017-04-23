class Alias < ActiveRecord::Base
  validates :dst, :rewrite_dst, presence: true
  validates :dst, uniqueness: { message: "route already exists" }
  validates :dst, :rewrite_dst, format: { with: /.+@.+/, message: "not an email" }
end
