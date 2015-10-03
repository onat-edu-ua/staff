class AccessGroup < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'access_groups'

  validates_presence_of :name, :tag
  validates_uniqueness_of :name, :tag
end