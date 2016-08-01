class EmailDomain < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'email_domains'

  validates_presence_of :domain
  validates_uniqueness_of :domain


  def domain=(nm)
    self[:domain] = nm.strip
  end

  def display_name
    domain
  end

end