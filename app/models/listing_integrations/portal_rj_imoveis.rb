class ListingIntegrations::PortalRjImoveis < ListingIntegration
  LOGIN_URL = "http://www.portalrjimoveis.com.br/restrito.php"
  NEW_LISTING_URL = "http://www.portalrjimoveis.com.br/anunciante/adicionar-cad.php"

  TYPE_MODIFICATIONS = {
    "Fazenda" => "Rural"
  }

  REQUIRED_FIELDS = [
    :reference, :transaction_type, :listing_type, :title, :description, :price,
    :square_feet, :state, :city, :district
  ]

  def fill_create_form
    session.fill_in "CODIGOREFERENCIA", with: self.listing.reference
    session.choose(self.listing.renting? ? "FINALIDADE_2" : "FINALIDADE_1")
    if TYPE_MODIFICATIONS[self.listing.listing_type]
      session.select TYPE_MODIFICATIONS[self.listing.listing_type], from: "TIPOIMOVEL"
    else
      session.select self.listing.listing_type, from: "TIPOIMOVEL"
    end
    session.fill_in "TITULO", with: self.listing.title
    session.fill_in "DESCRICAO", with: self.listing.description
    session.fill_in "PRECO", with: self.listing.price
    session.fill_in "AREA", with: self.listing.square_feet
    session.select "RJ", from: "ESTADO"
    session.select self.listing.city, from: "CIDADE"
    session.select self.listing.bedrooms, from: "DORMITORIOS"
    session.select self.listing.bathrooms, from: "BANHEIROS"
    session.select self.listing.suites, from: "SUITES"
    session.select self.listing.parking_spaces, from: "VAGAS"
    session.fill_in "BAIRRO", with: self.listing.district
    session.fill_in "CEP", with: self.listing.zipcode
    session.click_on "KT_Insert1"
  end

  def fill_update_form
    session.fill_in "CODIGOREFERENCIA_1", with: self.listing.reference
    session.choose(self.listing.renting? ? "FINALIDADE_1_2" : "FINALIDADE_1_1")
    if TYPE_MODIFICATIONS[self.listing.listing_type]
      session.select TYPE_MODIFICATIONS[self.listing.listing_type], from: "TIPOIMOVEL"
    else
      session.select self.listing.listing_type, from: "TIPOIMOVEL"
    end
    session.fill_in "TITULO_1", with: self.listing.title
    session.fill_in "DESCRICAO_1", with: self.listing.description
    session.fill_in "PRECO_1", with: self.listing.price
    session.fill_in "AREA_1", with: self.listing.square_feet
    session.select "RJ", from: "ESTADO"
    session.select self.listing.city, from: "CIDADE"
    session.select self.listing.bedrooms, from: "DORMITORIOS"
    session.select self.listing.bathrooms, from: "BANHEIROS"
    session.select self.listing.suites, from: "SUITES"
    session.select self.listing.parking_spaces, from: "VAGAS"
    session.fill_in "BAIRRO_1", with: self.listing.district
    session.fill_in "CEP_1", with: self.listing.zipcode
    session.first("input[name='KT_Update1']").click
  end

  def destroy_listing
    login
    session.visit listing_edit_url
    session.first("input[name='KT_Delete1']").click
    if session.text.include?("Exclusão realizada com sucesso")
      self.destroy
    end
  end

  def create_listing
    login
    session.visit NEW_LISTING_URL
    fill_create_form
    get_identifier
  end

  def update_listing
    login
    session.visit listing_edit_url
    fill_update_form
  end

  def get_identifier
    pkey = session.find("#imovel_foto")[:href].match(/IMOVEL_PKEY=(.*)/)[1]
    self.update_attribute :identifier, pkey
  end

  def login
    session.visit LOGIN_URL
    session.fill_in "kt_login_user", with: self.integration.username
    session.fill_in "kt_login_password", with: self.integration.password
    session.click_on "kt_login1"
  end

  def listing_url
    "http://www.portalrjimoveis.com.br/imoveis.php?imovel=#{self.identifier}" 
  end

  def listing_edit_url
    "http://www.portalrjimoveis.com.br/anunciante/editar.php?IMOVEL_PKEY=#{self.identifier}"
  end
end