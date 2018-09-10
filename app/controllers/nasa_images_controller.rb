class NasaImagesController < ApplicationController
  def new
    @errors = []
    @image_search = ImageSearch.new
    nav_button_active('new')
  end

  def create
    begin
      @image_search = ImageSearch.new(image_search_params)
      
      if @image_search.valid?
        NasaImage.delete_all
        @image_retriever = ImageDataRetriever.new(@image_search, 1)
        @nasa_images = get_nasa_data(@image_retriever, 1)
        NasaImage.create!(@nasa_images)
        redirect_to nasa_images_path
      else
        errors.concat @image_search.errors.full_messages if @image_search.errors.any?
        render 'new'
      end
      
    rescue => error
      errors.concat [ error.message ]
      render 'new'
    end
  end
  
  def index
    @page_count = 16
    @nasa_images = NasaImage.all.paginate(page: params[:page], per_page: @page_count)
    @total_image_count = @nasa_images.count
    @images_per_column = calculate_images_per_column(@page_count)
    nav_button_active('index')
  end

  def show
    @nasa_image = NasaImage.find(params[:id])
  end

  private
  
  def get_nasa_data(image_retriever, page)
    image_retriever.download_nasa_data
  end
  
  def errors
    @errors ||= []
  end

  def image_search_params
    params.require(:image_search).permit(:search_terms, :center, :description, :keywords, :location, :nasa_id, :title, :year_start, :year_end)
  end

  def nav_button_active(action)
    if action == 'index'
      @view_class = 'active'
      @download_class = ''
    else
      @view_class = ''
      @download_class = 'active'
    end
  end

  def calculate_images_per_column(page_count)
    (page_count / 4.to_f).ceil
  end  

end