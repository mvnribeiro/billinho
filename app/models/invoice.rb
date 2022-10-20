class Invoice < ApplicationRecord
  belongs_to :enrollment

  STATUS_OPTIONS = {
    aberta: 'aberta',
    atrasada: 'atrasada',
    paga: 'paga'
  }
  enum status: STATUS_OPTIONS

  validates :enrollment_id, :value, :due_date, :status, presence: true
  validates_numericality_of :value, greater_than: 0
  validate :valid_date?
  validates_inclusion_of :status, in: Invoice.statuses.keys

  private

  def valid_date?
    errors.add(:due_date, 'invalid date format') unless due_date.is_a?(Date)
  end
end
