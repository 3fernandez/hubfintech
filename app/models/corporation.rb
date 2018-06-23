class Corporation < Person
  validates :cnpj, :social_name, :trade_name, presence: true
end
