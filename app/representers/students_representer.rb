class StudentsRepresenter
  def initialize(students)
    @students = students
  end

  def as_json
    students.map do |student|
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
  end

  private

  attr_reader :students
end
