module ProductFetcher
  class Service
    AVAILABILITY_FIELD = 'availability'.freeze
    FIELDS_MAPPING = {
      name: ['og:title'],
      description: ['og:description'],
      price: ['product:price:amount', 'og:price:amount'],
      original_price: ['product:original_price:amount'],
      currency: ['product:price:currency', 'og:price:currency'],
      image_url: ['og:image'],
      canonical_url: ['og:url']
    }.freeze

    def initialize(url, retailer)
      response = HTTParty.get(url)
      @data = Nokogiri::HTML(response.parsed_response)
      @brand = retailer.name
    end

    def parse
      main_fields.merge(additional_fields)
    end

    private

    def main_fields
      FIELDS_MAPPING.map { |field, values| [field, parse_property(values)] }.to_h
    end

    def additional_fields
      { availability: availability_field, brand: @brand }
    end

    def availability_field
      @data.at("meta[itemprop=#{AVAILABILITY_FIELD}]")&.[]('content')
    end

    def parse_property(properties)
      properties.find do |property|
        field = @data.at("meta[property='#{property}']")&.[]('content')
        break field if field
      end
    end
  end
end
