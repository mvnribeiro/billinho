Faker::Config.locale = 'pt-BR'

(5).times do
  Institution.create!(
    name: "#{Faker::University.prefix} #{Faker::Name.last_name} #{Faker::University.suffix}",
    cnpj: Faker::IDNumber.unique.brazilian_id.to_i,
    type_of: %w[universidade creche escola].sample
    )
end

(15).times do
  Student.create!(
  name: "#{Faker::Name.name} #{Faker::Name.middle_name} #{Faker::Name.last_name}",
  cpf: Faker::IDNumber.unique.brazilian_citizen_number,
  birth_date: Faker::Date.between(from: '1900-01-01', to: '2004-01-01'),
  phone: "#{Faker::PhoneNumber.area_code}9#{Faker::PhoneNumber.subscriber_number}#{Faker::PhoneNumber.subscriber_number}",
  gender: %w[F M O].sample,
  payment_method: %w[cartão boleto].sample
  )
end

(1..15).each do |n|
  enrollment = Enrollment.create!(
    institution_id: rand(1..5),
    student_id: n,
    course_name: ['Biologia', 'Educação Física', 'Letras', 'Matemática', 'Ciência da Computação', 'Química', 'Física'].sample,
    total_value: rand(1_000.0..100_000.0),
    total_invoices: [6, 12, 18].sample,
    due_day: rand(1..31)
  )
  InvoiceGenerator.call(enrollment)
end
