class Institution < ApplicationRecord
  TYPES_OF_INSTITUTION = {
    universidade: 'universidade',
    escola: 'escola',
    creche: 'creche'
  }
  enum type_of: TYPES_OF_INSTITUTION

  has_many :enrollments
  validates :name, :cnpj, presence: true, uniqueness: true
  validates :cnpj, numericality: { only_integer: true }
  validates_inclusion_of :type_of,
                         in:
                           Institution.type_ofs.keys,
                         allow_blank: true
end
