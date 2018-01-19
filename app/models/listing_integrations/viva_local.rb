class ListingIntegrations::VivaLocal < ListingIntegration
  LOGIN_URL = "http://www.vivalocal.com/login.php"
  NEW_LISTING_URL = "http://post.vivalocal.com/"

  TRANSACTION_TYPE_MODIFICATIONS = {
    "Aluguel" => "Aluguel Imóveis",
    "Venda" => "Venda Imóveis",
    "Aluguel por Temporada" => "Aluguel Temporada"
  }
  REQUIRED_FIELDS = [
    :transaction_type, :state, :title, :description, :square_feet, :street, :city, :state
  ]
  

  def fill_form
    session.select self.listing.state_full, from: "postingGeo_1"
    session.fill_in "title", with: self.listing.title
    session.fill_in "detail", with: self.listing.description

    if self.listing.business?
      session.select "Imóveis comerciais", from: "posting_category_select"
      if self.listing.renting?
        session.find("input[value='storage_parking']").click
      else
        session.find("input[value='office_commercial']").click
      end
    elsif self.listing.farm?
      session.select "Terrenos e Lotes a Venda", from: "posting_category_select"
      session.first("input[name='price[price]']").set self.listing.price
    elsif self.listing.renting? || self.listing.renting_season?
      session.select TRANSACTION_TYPE_MODIFICATIONS[self.listing.transaction_type], from: "posting_category_select"
      session.first("input[name='price[rent]']").set self.listing.price
      session.select self.listing.bedrooms, from: "id_rooms"
      session.fill_in "id_surface", with: self.listing.square_feet
      session.fill_in "id_geo_address", with: "#{self.listing.street}, #{self.listing.city}, #{self.listing.state}"
    elsif self.listing.selling?
      session.select TRANSACTION_TYPE_MODIFICATIONS[self.listing.transaction_type], from: "posting_category_select"
      session.first("input[name='price[price]']").set self.listing.price
      session.select self.listing.bedrooms, from: "id_rooms"
      session.fill_in "id_surface", with: self.listing.square_feet
      session.fill_in "id_geo_address", with: "#{self.listing.street}, #{self.listing.city}, #{self.listing.state}"
    end

    session.check "term_checkbox"
    session.click_on "publish_button"
  end

  def destroy_listing
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
    binding.pry
    session.visit LOGIN_URL
    session.fill_in "email", with: self.integration.username
    session.fill_in "password", with: self.integration.password
    session.click_on("Entrar")
  end

  def get_identifier
  end

  def listing_edit_url
    "https://www.proprietariodireto.com.br/properties/#{self.identifier}/edit"
  end

  def listing_url
    "https://www.proprietariodireto.com.br/properties/#{self.identifier}/edit"
  end  
end