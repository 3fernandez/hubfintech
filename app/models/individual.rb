class Individual < Person
  validates :cpf, :full_name, :birthdate, presence: true
end
