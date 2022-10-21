class Student < ApplicationRecord
  GENDER_OPTIONS = {
    F: 'F',
    M: 'M',
    O: 'O'
  }
  PAYMENT_METHODS_OPTIONS = {
    cartão: 'cartão',
    boleto: 'boleto'
  }
  enum gender: GENDER_OPTIONS
  enum payment_method: PAYMENT_METHODS_OPTIONS

  has_many :enrollments
  has_many :invoices
  validates :name, :cpf, presence: true, uniqueness: true
  validates :phone, :cpf, length: { is: 11 }
  validate :valid_date?
  validates :phone, :cpf, numericality: { only_integer: true }
  validates :gender, :payment_method, presence: true
  validates_inclusion_of :gender,
                         in: Student.genders.keys
  validates_inclusion_of :payment_method,
                         in: Student.payment_methods.keys

  private

  def valid_date?
    errors.add(:birth_date, 'invalid date format') unless birth_date.is_a?(Date)
  end
end
