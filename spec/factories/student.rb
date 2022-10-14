FactoryBot.define do
  Faker::Config.locale = 'pt-BR'
  factory :student do
    name { "#{Faker::Name.name} #{Faker::Name.middle_name} #{Faker::Name.last_name}" }
    cpf { Faker::IDNumber.unique.brazilian_citizen_number.to_i }
    birth_date { Faker::Date.between(from: '1900-01-01', to: '2004-01-01') }
    phone { "#{PhoneNumber.area_code}9#{PhoneNumber.subscriber_number}#{PhoneNumber.subscriber_number}".to_i }
    gender { %w[F M O].sample}
    payment_method { %w[cartão boleto].sample }
  end
end


# formatted = ''
# phone.each_char.with_index do |n, idx|
#   p (idx != 1 || idx != 5)
#   p idx
#   formatted << ((idx != 1 or idx != 5) ? n : "#{n} ")
# end
# formatted