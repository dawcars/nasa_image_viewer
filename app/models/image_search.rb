class ImageSearch
  include ActiveModel::Model

  attr_accessor :search_terms, :center, :description, :keywords, :location, :nasa_id, :title, :year_start, :year_end

  validates :year_start, :year_end, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.today.year, only_integer: true, allow_blank: true }
  
  def attributes
    { 'search_terms' => nil, 'center' => nil, 'description' => nil, 'keywords' => nil, 'location' => nil, 'nasa_id' => nil, 'title' => nil, 'year_start' => nil, 'year_end' => nil }
  end
end
