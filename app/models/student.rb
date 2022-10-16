class Student < ApplicationRecord
  GENDERS_OPTIONS = {
    F: 'F',
    M: 'M',
    O: 'O'
  }
  PAYMENT_METHODS_OPTIONS = {
    cartão: 'cartão',
    boleto: 'boleto'
  }
  enum gender: GENDERS_OPTIONS
  enum payment_method: PAYMENT_METHODS_OPTIONS

  has_many :enrollments
  validates :name, :cpf, presence: true, uniqueness: true
  validates :cpf, numericality: { only_integer: true }
  validates :cpf, :phone, length: { is: 11 }
  validate :valid_date?
  validates :phone, numericality: { only_integer: true }
  validates :gender, :payment_method, presence: true
  validate :cpf_format
  validates_inclusion_of :gender,
                         in: Student.genders.keys
  validates_inclusion_of :payment_method,
                         in: Student.payment_methods.keys

  private

  def valid_date?
    errors.add(:birth_date, 'invalid date format') unless birth_date.is_a?(Date)
  end

  def cpf_format
    self.cpf = "#{self.cpf[0,3]}.#{self.cpf[3,3]}.#{self.cpf[6,3]}-#{self.cpf[9,2]}" if !self.cpf.nil? && self.cpf.length == 11
  end
end
