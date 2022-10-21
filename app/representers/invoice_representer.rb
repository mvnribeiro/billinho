class InvoiceRepresenter
  def initialize(invoice)
    @invoice = invoice
  end

  def as_json
    {
      id: invoice.id,
      enrollment_id: invoice.enrollment_id,
      institution_id: invoice.institution_id,
      student_id: invoice.student_id,
      value: invoice.value,
      due_date: invoice.due_date,
      status: invoice.status
    }
  end

  private

  attr_reader :invoice
end
