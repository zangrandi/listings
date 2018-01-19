class ListingIntegrationsController < ApplicationController
  def index
    @listing = current_user.listings.find(params[:listing_id])
  end

  def new
    @listing = current_user.listings.find(params[:listing_id])
    @listing.integrations_possible_to_select.map do |integration|
      @listing.listing_integrations.find_or_initialize_by(integration_id: integration.id)
    end
  end

  def create
    @listing = current_user.listings.find(params[:listing_id])
    @listing.update_attributes(listing_params)
    @listing.publish_integrations
    redirect_to listing_integrations_path(@listing)
  end

  def destroy
    @listing = current_user.listings.find(params[:listing_id])
    @listing_integration = @listing.listing_integrations.find(params[:id])
    @listing_integration.destroy_listing
    redirect_to listing_integrations_path(@listing)
  end

  private

    def listing_params
      params.require(:listing).permit!
    end
end
