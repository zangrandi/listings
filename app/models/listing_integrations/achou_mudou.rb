class ListingIntegrations::AchouMudou < ListingIntegration
  LOGIN_URL = "https://www.achoumudou.com.br/login.php"
  NEW_LISTING_URL = "https://www.achoumudou.com.br/imovel-cadastro.php"

  TRANSACTION_TYPE_MODIFICATIONS = {
    "Aluguel" => "Alugar",
    "Aluguel por Temporada" => "Alugar por temporada",
    "Venda" => "Vender"
  }

  TYPE_MODIFICATIONS = {
    "Fazenda" => "Rural"
  }

  REQUIRED_FIELDS = [
    :transaction_type, :listing_type, :title, :district, :state, :city, :description
  ]

  def fill_form
    session.within("#miolo") do
      session.select TRANSACTION_TYPE_MODIFICATIONS[self.listing.transaction_type], from: "selint"
      if TYPE_MODIFICATIONS[self.listing.listing_type]
        session.select TYPE_MODIFICATIONS[self.listing.listing_type], from: "seltip"
      else
        session.select self.listing.listing_type, from: "seltip"
      end
      session.first("input[name='frmtit']").set self.listing.title
      session.fill_in "inpval", with: self.listing.price
      session.first("textarea[name='frmdes']").set self.listing.description
      session.first("input[name='frmend']").set self.listing.street
      session.select self.listing.state, from: "cadest"
      session.select I18n.transliterate(self.listing.city.upcase), from: "cadcid"
      session.select self.listing.bedrooms, from: "selqua"
      session.first("input[name='frmbai']").set self.listing.district
      session.click_on "butcon"
    end
  end

  def destroy_listing
    login
    response = session.visit destroy_listing_url
    if response["status"] == "success"
      self.destroy
    end
  end

  def create_listing
    login
    session.visit NEW_LISTING_URL
    fill_form
    get_identifier
  end

  def update_listing
    login
    session.visit listing_edit_url
    fill_form
  end

  def get_identifier
    cod = session.first(".boxval").first("span").text.gsub(/\D/,"")
    self.update_attribute :identifier, cod
  end

  def login
    session.visit LOGIN_URL
    session.first("input[name='usuario']").set self.integration.username
    session.first("input[name='senha']").set self.integration.password
    session.click_on "butcon"
  end

  def destroy_listing_url
    "https://www.achoumudou.com.br/funcoes/excluir.php?codigo=#{self.identifier}"
  end

  def listing_url
    "https://www.achoumudou.com.br/#{self.identifier}/titulo" 
  end

  def listing_edit_url
    "https://www.achoumudou.com.br/imovel-altera.php?codigo=#{self.identifier}"
  end
end