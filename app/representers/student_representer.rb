class StudentRepresenter
  def initialize(student)
    @student = student
  end

  def as_json
    {
      id: student.id,
      name: student.name,
      cpf: student.cpf,
      birth_date: student.birth_date,
      phone: student.phone,
      gender: student.gender,
      payment_method: student.payment_method
    }
  end

  private

  attr_reader :student
end
