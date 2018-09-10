require 'rails_helper'

describe NasaImagesController do
  describe "GET index" do
    it "assigns @nasa_images" do
      #nasa_image = NasaImage.create
      nasa_image = create(:nasa_image)
      get :index
      expect(assigns(:nasa_images)).to eq([nasa_image])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end 
  
  describe "GET show" do
    it "assigns @nasa_image" do
      nasa_image = create(:nasa_image)
      get :show, params: { id: nasa_image.id }
      expect(assigns(:nasa_image)).to eq(nasa_image)
    end

    it "renders the show template" do
      nasa_image = create(:nasa_image)
      get :show, params: { id: nasa_image.id }
      expect(response).to render_template("show")
    end
  end 
  
  describe "GET #new" do   
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      let(:image_search) { build(:image_search) }
      let(:image_retriever) { ImageDataRetriever.new(image_search, 1) }
      let(:nasa_images) {
         { center: 'JPL', date_image_created: '1964-01-01', description: '', keywords: '', media_type: '', nasa_id: '', title: '', image_collection_url: '', thumbnail_url: '' }
      }
      
      it "creates a new nasa_image object" do	 
        allow(subject).to receive(:get_nasa_data) { nasa_images }
        expect{
          post :create, params: { image_search: attributes_for(:image_search) }
        }.to change(NasaImage,:count).by(1)
      end
      
      it "redirects to index" do
	allow(subject).to receive(:get_nasa_data) { nasa_images }
        post :create, params: { image_search: attributes_for(:image_search) }
        is_expected.to redirect_to(action: :index)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new nasa image" do
        expect{
          post :create, params: { image_search: attributes_for(:invalid_image_search) }
        }.to_not change(NasaImage,:count)
      end
      
      it "re-renders the new method" do
        post :create, params: { image_search: attributes_for(:invalid_image_search)}
	expect(response).to render_template("new")
      end
    end 
  end
  
end