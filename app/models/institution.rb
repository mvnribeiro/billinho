class Institution < ApplicationRecord
  TYPES_OF_INSTITUTION = {
    universidade: 'universidade',
    escola: 'escola',
    creche: 'creche'
  }.freeze
  enum type_of: TYPES_OF_INSTITUTION

  has_many :enrollments
  has_many :invoices
  validates :name, :cnpj, presence: true, uniqueness: true
  validates :cnpj, numericality: { only_integer: true }
  validates_inclusion_of :type_of,
                         in:
                           Institution.type_ofs.keys,
                         allow_blank: true
end
