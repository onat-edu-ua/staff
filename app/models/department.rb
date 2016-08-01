class Department < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'departments'

  validates_presence_of :name
  validates_uniqueness_of :name


  def name=(nm)
    self[:name] = nm.strip
  end

end