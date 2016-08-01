class AccessGroup < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'access_groups'

  validates_presence_of :name, :tag
  validates_uniqueness_of :name, :tag

  def self.collection
    order(:name)
  end


  def name=(nm)
    self[:name] = nm.strip
  end

  def tag=(nm)
    self[:tag] = nm.strip
  end


end