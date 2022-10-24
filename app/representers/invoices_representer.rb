class InvoicesRepresenter
  def initialize(invoices)
    @invoices = invoices
  end

  def as_json
    invoices.map do |invoice|
      {
        id: invoice.id,
        enrollment_id: invoice.enrollment_id,
        institution_id: invoice.institution_id,
        student_id: invoice.student_id,
        value: invoice.value.round(2),
        due_date: invoice.due_date,
        status: invoice.status
      }
    end
  end

  private

  attr_reader :invoices
end
