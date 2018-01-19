class PublishIntegrationJob
  attr_reader :listing_integration

  def initialize(listing_integration_id)
    @listing_integration = ListingIntegration.find(listing_integration_id)
  end

  def perform
    if @listing_integration.identifier
      @listing_integration.update_listing
    else
      @listing_integration.create_listing
    end
  end
end
