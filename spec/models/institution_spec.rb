require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'Associations' do
    it { should have_many(:enrollments) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_uniqueness_of(:cnpj) }
    it { should validate_numericality_of(:cnpj) }
    it do
      should define_enum_for(:type_of)
        .with_values(
          universidade: 'universidade',
          escola: 'escola',
          creche: 'creche'
        )
        .backed_by_column_of_type(:string)
    end
  end
end
