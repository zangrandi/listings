class Listing < ApplicationRecord
  include Listing::Integrations

  has_many :listing_integrations
  has_many :images
  belongs_to :user
  accepts_nested_attributes_for :listing_integrations, allow_destroy: true

  TYPES = [
    "Apartamento",
    "Casa",
    "Comercial",
    "Cobertura",
    "Flat",
    "Kitchenette",
    "Loft",
    "Sobrado",
    "Terreno",
    "Fazenda",
    "Chácara"
  ]

  TRANSACTION_TYPES = [
    "Aluguel",
    "Venda",
    "Aluguel por Temporada"
  ]

  STATES = {
    "Acre" => "AC",
    "Alagoas" => "AL",
    "Amapá" => "AP",
    "Amazonas" => "AM",
    "Bahia" => "BA",
    "Ceará" => "CE",
    "Distrito Federal" => "DF",
    "Espírito Santo" => "ES",
    "Goiás" => "GO",
    "Maranhão" => "MA",
    "Mato Grosso" => "MT",
    "Mato Grosso do Sul" => "MS",
    "Minas Gerais" => "MG",
    "Pará" => "PA",
    "Paraíba" => "PB",
    "Paraná" => "PR",
    "Pernambuco" => "PE",
    "Piauí" => "PI",
    "Roraima" => "RR",
    "Rondônia" => "RO",
    "Rio de Janeiro" => "RJ",
    "Rio Grande do Norte" => "RN",
    "Rio Grande do Sul" => "RS",
    "Santa Catarina" => "SC",
    "São Paulo" => "SP",
    "Sergipe" => "SE",
    "Tocantins" => "TO"
  }

  def full_address
    "#{city}/#{state}"
  end

  def selling?
    self.transaction_type == "Venda"
  end

  def renting?
    self.transaction_type == "Aluguel"
  end

  def renting_season?
    self.transaction_type == "Aluguel por Temporada"
  end

  def state_full
    STATES.key(self.state)
  end

  def business?
    self.listing_type = "Comercial"
  end

  def farm?
    self.listing_type = "Fazenda"
  end
end