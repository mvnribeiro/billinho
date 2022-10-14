FactoryBot.define do
  Faker::Config.locale = 'pt-BR'
  factory :institution do
    name { Faker::University.unique.name }
    cnpj { Faker::IDNumber.unique.brazilian_id.to_i }
    type_of { %w[universidade creche escola].sample }
  end
end
