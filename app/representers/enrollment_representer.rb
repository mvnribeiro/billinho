class EnrollmentRepresenter
  def initialize(enrollment)
    @enrollment = enrollment
  end

  def as_json
    {
      id: enrollment.id,
      institution_id: enrollment.institution_id,
      student_id: enrollment.student_id,
      course_name: enrollment.course_name,
      total_value: enrollment.id,
      invoices: enrollment.invoices,
      due_date: enrollment.due_date
    }
  end

  private

  attr_reader :enrollment
end
