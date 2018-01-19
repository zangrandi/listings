class Integration < ApplicationRecord
  INTEGRATIONS = {
    "ListingIntegrations::PortalRjImoveis" => "Portal RJ Imóveis",
    "ListingIntegrations::AchouMudou" => "Achou Mudou",
    "ListingIntegrations::ProprietarioDireto" => "Proprietário Direto"
  }.freeze

  belongs_to :user

  def fakepassword
    self.password.gsub(/./,"*") if self.password
  end

  def site_name
    Integration::INTEGRATIONS[self.name]
  end
end