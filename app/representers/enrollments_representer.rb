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
        total_invoices: enrollment.total_invoices,
        due_day: enrollment.due_day
      }
    end
  end

  private

  attr_reader :enrollments
end
