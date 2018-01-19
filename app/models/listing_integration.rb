require "capybara"
require "capybara/poltergeist"

class ListingIntegration < ApplicationRecord
  belongs_to :listing
  belongs_to :integration

  scope :published, -> { where("identifier is not null") }
  scope :not_published, -> { where("identifier is null") }

  def name
    Integration::INTEGRATIONS[type]
  end

  def session
    @session ||= Capybara::Session.new(:poltergeist_no_js)
  end
end
