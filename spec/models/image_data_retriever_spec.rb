require 'rails_helper'

describe ImageDataRetriever do  
  let(:image_search) { build(:image_search) }
  let(:nasa_images) {
      build_list(:nasa_image, 3).to_json
  }
  subject { described_class.new(image_search, 1) }
  
  it { is_expected.to respond_to(:get_data) }
  it { is_expected.to respond_to(:download_nasa_data) }
  
  describe "#initialize" do
    it "initializes with api_options" do
      expect(subject.api_options).not_to be_nil
    end 
    
    it "initializes with api_options as a hash" do
      expect(subject.api_options).to be_kind_of(Hash)
    end 
    
    it "initializes api_options q with value of search_terms" do
      expect(subject.api_options[:query][:q] ).to eq(image_search.search_terms)
    end 
    
    it "initializes api_options center with value of center" do
      expect(subject.api_options[:query]['center'] ).to eq(image_search.center)
    end 
    
    it "initializes api_options description with value of description" do
      expect(subject.api_options[:query]['description']  ).to eq(image_search.description)
    end 
    
    it "initializes api_options keywords with value of keywords" do
      expect(subject.api_options[:query]['keywords']  ).to eq(image_search.keywords)
    end 
    
    it "initializes api_options location with value of location" do
      expect(subject.api_options[:query]['location']  ).to eq(image_search.location)
    end 
    
    it "initializes api_options nasa_id with value of nasa_id" do
      expect(subject.api_options[:query]['nasa_id']  ).to eq(image_search.nasa_id)
    end 
    
    it "initializes api_options title with value of title" do
      expect(subject.api_options[:query]['title']  ).to eq(image_search.title)
    end 
    
    it "initializes api_options year_start with value of year_start" do
      expect(subject.api_options[:query]['year_start']  ).to eq(image_search.year_start)
    end 
    
    it "initializes api_options year_start with value of year_end" do
      expect(subject.api_options[:query]['year_end']  ).to eq(image_search.year_end)
    end 
  end
  
  describe "#download_nasa_data" do    
    let(:api_data) { 
      { "collection" => { "items" => [ { "data" => [{ "center" => "JPL", "date_created" => "1965-01-01", "description" => "", "keywords" => "", "media_type" => "image", "nasa_id" => "", "title" => "" }], "href" => '', "links" => [ { "href" => '' } ] } ] } } 
    }
    let(:parsed_output) {
      { center: 'JPL', date_image_created: '1965-01-01', description: '', keywords: '', media_type: 'image', nasa_id: '', title: '', image_collection_url: '', thumbnail_url: '' }
    }
    
    it "parses api data correctly" do
      expect( subject.send(:parse_nasa_data, api_data)).to eq([parsed_output])
    end
    
    it "does not raise an error if status code is 200" do
      response = instance_double(HTTParty::Response, :code => 200)
      allow(subject).to receive(:get_data).and_return(response)  
      allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
      expect{ subject.download_nasa_data }.to_not raise_error
    end
    
    context "returns error status code" do 
      it "raises an error if status code is 400" do
        response = instance_double(HTTParty::Response, :code => 400)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
      
      it "raises an error if status code is 404" do
        response = instance_double(HTTParty::Response, :code => 404)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
      
      it "raises an error if status code is 500" do
        response = instance_double(HTTParty::Response, :code => 500)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
      
      it "raises an error if status code is 502" do
        response = instance_double(HTTParty::Response, :code => 502)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
      
      it "raises an error if status code is 503" do
        response = instance_double(HTTParty::Response, :code => 503)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
      
      it "raises an error if status code is 504" do
        response = instance_double(HTTParty::Response, :code => 504)
        allow(subject).to receive(:get_data).and_return(response)  
        allow(subject).to receive(:parse_nasa_data).and_return(parsed_output)   
        expect{ subject.download_nasa_data }.to raise_error(ImageDataRetrieverError)
      end 
    end
    
  end

end