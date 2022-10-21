FactoryBot.define do
  factory :invoice do
    enrollment
    institution
    student
    value { enrollment.total_value / enrollment.total_invoices }
    due_date { Faker::Date.forward(days: 30) }
    status { 'aberta' }
  end
end