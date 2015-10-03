class Employee < ActiveRecord::Base
  has_paper_trail
  self.table_name = 'employees'

  validates_presence_of :first_name, :last_name, :department, :position
  validates_uniqueness_of :login

  belongs_to :department, class_name: Department, foreign_key: :department_id
  belongs_to :position, class_name: EmployeePosition, foreign_key: :position_id

  before_create do
    generate_auth
  end


  private

  def generate_auth
    p "HUI"
    self.login=first_name
    self.password=last_name
  end

end