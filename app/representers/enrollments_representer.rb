class EnrollmentsRepresenter
  def initialize(enrollments)
    @enrollments = enrollments
  end

  def as_json
    enrollments.map do |enrollment|
      {
        id: enrollment.id,
        institution_id: enrollment.institution_id,
        student_id: enrollment.student_id,
        course_name: enrollment.course_name,
        total_value: enrollment.total_value,
        invoices: enrollment.invoices,
        due_date: enrollment.due_date
      }
    end
  end

  private

  attr_reader :enrollments
end
