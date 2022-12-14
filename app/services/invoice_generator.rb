class InvoiceGenerator
  attr_reader :enrollment_id, :institution_id, :student_id, :value, :due_day, :invoices

  def initialize(enrollment)
    @enrollment_id = enrollment.id
    @institution_id = enrollment.institution_id
    @student_id = enrollment.student_id
    @invoices = enrollment.total_invoices
    @value = enrollment.total_value / invoices
    @due_day = enrollment.due_day
  end

  def self.call(*args)
    new(*args).generate_invoices
  end

  def starting_month
    if Date.today.day >= due_day
      Date.today.next_month.month
    else
      Date.today.month
    end
  end

  def set_due_date(year, month)
    Date.new(year, month, due_day)
  rescue Date::Error
    Date.new(year, month, -1)
  end

  def generate_invoices
    due_date = set_due_date(Date.today.year, starting_month)

    invoices.times do
      create_invoice(due_date)
      due_date = set_due_date(due_date.next_month.year, due_date.next_month.month)
    end
  end

  def create_invoice(due_date)
    @invoice = Invoice.create!({
                                 enrollment_id:,
                                 institution_id:,
                                 student_id:,
                                 value:,
                                 due_date:,
                                 status: 'aberta'
                               })
    render json: @invoice.errors, status: :unprocessable_entity unless @invoice.save
  end
end
