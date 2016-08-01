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


  def access_groups
    @r ||= AccessGroup.where(id: access_group_ids)
  end

  def access_groups_list
    access_groups.map(&:name).join(",")
  end

  def access_group_ids=(ids) # removing zero element from array
    self[:access_group_ids] = ids.reject { |i| i.blank? }
  end

  def first_name=(nm)
    self[:first_name] = nm.strip
  end

  def last_name=(nm)
    self[:last_name] = nm.strip
  end

  def middle_name=(nm)
    self[:middle_name] = nm.strip
  end

  scope :access_group_in, ->(*ids) {
    p *ids
    where("access_group_ids @>ARRAY[?]", ids.to_a.map(&:to_i))
  }
  scope :fio_contains, ->(name) { where("last_name||first_name||COALESCE(middle_name) ilike ?", "%#{name}%") }

  def fio
    "TEST FIO"
  end

  private

  def self.ransackable_scopes(auth_object = nil)
    [
        :access_group_in,
        :fio_contains
    ]
  end

  def generate_auth
    p "HUI"
    self.login=first_name
    self.password=last_name
  end

end