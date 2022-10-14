class Institution < ApplicationRecord
  TYPE_OF_CATEGORIES = {
    universidade: 'universidade',
    escola: 'escola',
    creche: 'creche'
  }
  enum type_of: TYPE_OF_CATEGORIES

  has_many :enrollments
  validates :name, :cnpj, :type_of, presence: true
  validates :name, :cnpj, uniqueness: true
  validates :cnpj, numericality: { only_integer: true }
  validates_inclusion_of :type_of, in: Institution.type_ofs.keys
end
