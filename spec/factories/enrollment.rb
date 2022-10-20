FactoryBot.define do
  factory :enrollment do
    institution
    student
    course_name { ['Biologia', 'Educação Física', 'Letras', 'Matemática', 'Ciêmcia da Computação', 'Química', 'Matemática'].sample }
    total_value { rand(100.0..100_000.0) }
    total_invoices { [1, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60].sample }
    due_day { rand(1..31) }
  end
end
