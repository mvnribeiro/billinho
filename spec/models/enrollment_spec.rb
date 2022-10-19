require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'Associations' do
    it { should belong_to(:student) }
    it { should belong_to(:institution) }
  end

  describe 'Validations' do
    %i[total_value invoices due_date course_name].each do |attr|
      it { should validate_presence_of(attr) }
    end
    it { should validate_numericality_of(:total_value).is_greater_than(0) }
    it { should validate_numericality_of(:invoices).is_greater_than(0) }
    it { should validate_inclusion_of(:due_date).in_range(1..31) }
  end
end
