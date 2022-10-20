FactoryBot.define do
  factory :invoice do
    enrollment
    value { enrollment.total_value / enrollment.total_invoices }
    sequence(:due_date, 1) { |n| Date.new(2023, n, enrollment.due_day) }
    status { 'aberta' }
  end
end