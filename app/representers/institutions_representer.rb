class InstitutionsRepresenter
  def initialize(institutions)
    @institutions = institutions
  end

  def as_json
    institutions.map do |institution|
      {
        id: institution.id,
        name: institution.name,
        cnpj: institution.cnpj,
        type_of: institution.type_of
      }
    end
  end

  private

  attr_reader :institutions
end
