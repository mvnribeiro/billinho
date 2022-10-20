require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Associations' do
    it { should belong_to(:enrollment) }
  end

  describe 'Validations' do
    %i[enrollment_id value due_date status].each do |attr|
      it { should validate_presence_of(attr) }
    end
    it { should validate_numericality_of(:value).is_greater_than(0) }
    it { should allow_value('2012-12-21').for(:due_date) }
    it { should_not allow_value('2012a12a21').for(:due_date) }

    it do
      should define_enum_for(:status)
        .with_values(
          aberta: 'aberta',
          atrasada: 'atrasada',
          paga: 'paga'
        )
        .backed_by_column_of_type(:string)
    end
  end
end
