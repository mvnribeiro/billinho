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
  validates :name, :cpf, presence: true, uniqueness: true
  validates :phone, length: { is: 11 }
  validate :valid_date?
  validates :phone, numericality: { only_integer: true }
  validates :gender, :payment_method, presence: true
  validates_inclusion_of :gender,
                         in: Student.genders.keys
  validates_inclusion_of :payment_method,
                         in: Student.payment_methods.keys
  validate :format_cpf, on: :create

  private

  def valid_date?
    errors.add(:birth_date, 'invalid date format') unless birth_date.is_a?(Date)
  end

  def valid_cpf?
    !cpf.nil? && cpf.length == 11 && cpf !~ /\D/
  end

  def format_cpf
    if valid_cpf?
      self.cpf = "#{cpf[0,3]}.#{cpf[3,3]}.#{cpf[6,3]}-#{cpf[9,2]}"
    else
      errors.add(:cpf, 'invalid cpf: must be 11 digits')
    end
  end
end
