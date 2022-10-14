class InstitutionRepresenter
  def initialize(institution)
    @institution = institution
  end

  def as_json
    {
      id: institution.id,
      name: institution.name,
      cnpj: institution.cnpj,
      type_of: institution.type_of
    }
  end

  private
  attr_reader :institution
end