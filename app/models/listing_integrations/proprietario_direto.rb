class ListingIntegrations::ProprietarioDireto < ListingIntegration
  LOGIN_URL = "https://www.proprietariodireto.com.br/"
  NEW_LISTING_URL = "https://www.proprietariodireto.com.br/imoveis-direto-com-proprietario-cadastrar-imovel"

  REQUIRED_FIELDS = [
    :title, :city, :state, :price, :square_feet, :bedrooms, :phone, :description,
    :district, :street
  ]

  def fill_form
    session.first("input[name='title']").set self.listing.title
    if self.listing.selling?
      session.first("input[name='sale']").set self.listing.price
    else
      session.first("input[name='rent']").set self.listing.price
    end
    session.first("select[name='kind']").set(self.listing.listing_type)
    session.first("input[name='area']").set self.listing.square_feet
    session.first("input[name='room']").set self.listing.bedrooms
    session.first("input[name='vacancies']").set self.listing.parking_spaces
    session.first("input[name='phone']").set self.listing.phone
    session.first("textarea[name='desc']").set self.listing.description
    session.first("input[name='address']").set "#{self.listing.city} #{self.listing.state}"
    session.first("input[name='address']").native.send_keys(:return)
    # session.first("input[name='city']").set self.listing.city
    # session.first("input[name='city']").native.send_keys(:return)
    session.first("input[name='route']").set self.listing.street
    session.first("input[name='neighborhood']").set self.listing.district
    session.first("#confirmed").click
    session.first("button[name='save']").click
  end

  def destroy_listing
    login
    response = session.visit listing_edit_url
    session.click_on "delete-property"
    session.find("input[value='Sim']").click
    if session.current_path == "/imoveis"
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

  def login
    session.visit LOGIN_URL
    session.all("input[name='email']")[0].set self.integration.username
    session.all("input[name='password']")[0].set self.integration.password
    session.all("input[name='email']", visible: false)[1].set self.integration.username
    session.all("input[name='password']", visible: false)[1].set self.integration.password
    session.click_on("Fazer login")
  end

  def get_identifier
    cod = session.all(".list-item-widget").last.find("a")[:href].match(/properties\/(.*)\/edit/)[1]
    self.update_attribute :identifier, cod
  end

  def listing_edit_url
    "https://www.proprietariodireto.com.br/properties/#{self.identifier}/edit"
  end

  def listing_url
    "https://www.proprietariodireto.com.br/properties/#{self.identifier}/edit"
  end
end