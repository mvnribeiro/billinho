class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student

  has_many :invoices

  validates :institution_id, :student_id, :total_value, :total_invoices, :due_day, :course_name, presence: true
  validates_numericality_of :total_value, greater_than: 0
  validates_numericality_of :total_invoices, greater_than: 0
  validates_inclusion_of :due_day, { in: 1..31 }
end
