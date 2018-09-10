class ImageDataRetriever
  include HTTParty
  base_uri 'https://images-api.nasa.gov/search'
  attr_reader :api_options, :data_items
  
  def initialize(image_search, page)   
    @api_options = { query: query_conditions(image_search, page) }
  end
  
  def download_nasa_data()
    @data_items = get_data()
    nasa_images = []
      
    case @data_items.code
    when 200
      nasa_images = parse_nasa_data(@data_items)
    when 400
      raise ImageDataRetrieverError.new('400 - Bad API Request')
    when 404
      raise ImageDataRetrieverError.new('404 - Nasa API Resource Not Found')
    when 500, 502, 503, 504
      raise ImageDataRetrieverError.new(@data_items.code.to_s + ' Nasa API Server Error')
    end   
    nasa_images
  end
  
  def get_data()
    self.class.get("", @api_options) || []
  end

  private

  def query_conditions(image_search, page)
    query_conditions = { media_type: "image", page: page }
    query_conditions[:q] = image_search.search_terms unless image_search.search_terms.blank?

    # Getting all the ImageSearch object attributes and creating a query hash of the values to pass to the nasa api
    # Nasa expects query fields with the same name as all ImageSearch attributes other than 'search_terms'
    image_search.attributes.keys.each do |attr|
      if attr != "search_terms"
        query_conditions[attr] = image_search.send(attr) unless image_search.send(attr).blank?
      end
    end    

    query_conditions
  end
  
  def parse_nasa_data(data_items)
    nasa_images = []
    if !data_items.nil? and data_items.count > 0 and !data_items["collection"].nil? and data_items["collection"].count > 0
      items = data_items["collection"]["items"] 

      items.each do |item|
        data = item["data"][0]
        links = item["links"][0]

        # Preparing nasa_image as a hash rather than a NasaImage instance so that several can be created at once using the create! method
        nasa_image = { center: data['center'], date_image_created: data['date_created'], description: data['description'], keywords: data['keywords'], media_type: data['media_type'], nasa_id: data['nasa_id'], title: data['title'], image_collection_url: item['href'], thumbnail_url: links['href'] }

        nasa_images << nasa_image
      end
    end
    nasa_images
  end
end