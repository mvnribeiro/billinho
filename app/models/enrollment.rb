class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student

  validates :total_value, :invoices, :due_date, :course_name, presence: true
  validates_numericality_of :total_value, greater_than: 0
  validates_numericality_of :invoices, greater_than: 0
  validates_inclusion_of :due_date, { in: 1..31 }
end
