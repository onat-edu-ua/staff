class Email < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'emails'

  belongs_to :domain, class_name: EmailDomain, foreign_key: :domain_id
  belongs_to :employee, class_name: Employee, foreign_key: :employee_id

  validates_presence_of :domain_id, :username, :password
  validates_uniqueness_of :username, scope: [:domain_id]


end