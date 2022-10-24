FactoryBot.define do
  factory :enrollment do
    institution
    student
    course_name { ['Biologia', 'Educação Física', 'Letras', 'Matemática', 'Ciência da Computação', 'Química', 'Matemática', 'Jornalismo', 'Filosofia'].sample }
    total_value { rand(100.0..100_000.0) }
    total_invoices { [1, 6, 12, 18, 24, 30].sample }
    due_day { rand(1..31) }
  end
end
