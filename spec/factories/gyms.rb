FactoryBot.define do
  factory :gym do
    name { FFaker::Company.name }
    document_number { FFaker::IdentificationBR.cnpj }
    document_type { 'cnpj' }
    email { FFaker::Internet.email }
    config { {} }
  end
end
