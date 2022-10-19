FactoryBot.define do
  factory :enrollment do
    association :student, :institution
    total_value { rand(100.0..100_000.0) }
    invoices { [1, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60].sample }
    due_date { rand(1..31) }
  end
end
