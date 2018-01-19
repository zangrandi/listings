module Listing::Integrations
  extend ActiveSupport::Concern
  
  included do
    def publish_integrations
      self.integrations_possible_to_publish.each do |listing_integration|
        Delayed::Job.enqueue(
          PublishIntegrationJob.new(listing_integration.id), queue: "queue_publish_#{listing_integration.id}"
        )
      end    
    end

    def integration_possible?(integration)
      !integration.name.constantize::REQUIRED_FIELDS.any? { |field| self.send(field).blank? }
    end

    def missing_fields(integration)
      integration.name.constantize::REQUIRED_FIELDS.select { |field| self.send(field).blank? }
    end

    def integrations_possible_to_select
      self.user.integrations.select { |integration| self.integration_possible?(integration) }
    end

    def integrations_impossible_to_select
      self.user.integrations.select { |integration| !self.integration_possible?(integration) }
    end

    def integrations_possible_to_publish
      self.listing_integrations.select { |li| self.integration_possible?(li.integration) }
    end

    def integration_impossible_to_publish
      self.listing_integrations.select { |li| !self.integration_possible?(li.integration) }
    end

    def integrations_failed
      self.listing_integrations.not_published - self.integrations_publishing
    end

    def integrations_completed
      self.listing_integrations.published - self.integrations_updating
    end

    def integrations_publishing
      self.listing_integrations.not_published.select do |integration| 
        Delayed::Job.find_by(queue: "queue_publish_#{integration.id}")
      end
    end

    def integrations_updating
      self.listing_integrations.published.select do |integration| 
        Delayed::Job.find_by(queue: "queue_publish_#{integration.id}")
      end
    end
  end
end