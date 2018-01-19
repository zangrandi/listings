class ListingsController < ApplicationController
  def index
    @listings = current_user.listings
  end

  def new
    @listing = current_user.listings.build
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to new_listing_integration_path(@listing)
    else
      render :new
    end
  end

  def update
    @listing = current_user.listings.find(params[:id])

    if @listing.update_attributes(listing_params)
      redirect_to new_listing_integration_path(@listing)
    else
      render :edit
    end
  end

  def destroy
    @listing = current_user.listings.find(params[:id])
    @listing.destroy
    redirect_to listings_path, notice: "Publicação removida com sucesso."
  end

  private

    def listing_params
      params.require(:listing).permit!
    end
end
