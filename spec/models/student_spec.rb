require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'Associations' do
    it { should have_many(:enrollments) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf) }
    it { should allow_value('99111117777').for(:cpf) }
    it { should_not allow_value('2222').for(:cpf) }
    it { should_not allow_value('1111A').for(:cpf) }

    it { should allow_value('2012-12-21').for(:birth_date) }

    it { should validate_numericality_of(:phone) }
    it { should validate_length_of(:phone).is_equal_to(11) }

    it do
      should define_enum_for(:gender)
        .with_values(
          F: 'F',
          M: 'M',
          O: 'O'
        )
        .backed_by_column_of_type(:string)
    end

    it do
      should define_enum_for(:payment_method)
        .with_values(
          cartão: 'cartão',
          boleto: 'boleto'
        )
        .backed_by_column_of_type(:string)
    end
  end
end
