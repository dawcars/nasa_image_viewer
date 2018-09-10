require 'rails_helper'

describe ImageSearch, :type => :model do
  subject { build(:image_search) }
  
  it { is_expected.to respond_to(:attributes) }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  context "year_start not valid" do
    it "is not valid if year start is not an integer" do
      subject.year_start = 'x'
      expect(subject).to_not be_valid
    end
    
    it "is not valid if year start is less than 1900" do
      subject.year_start = 1899
      expect(subject).to_not be_valid
    end
    
    it "is not valid if year start is greater than this year" do
      subject.year_start = Date.today.year + 1
      expect(subject).to_not be_valid
    end
  end
  
  context "year_end not valid" do
    it "is not valid if year end is not an integer" do
      subject.year_end = 'x'
      expect(subject).to_not be_valid
    end
    
    it "is not valid if year end is less than 1900" do
      subject.year_end = 1899
      expect(subject).to_not be_valid
    end
    
    it "is not valid if year end is greater than this year" do
      subject.year_end = Date.today.year + 1
      expect(subject).to_not be_valid
    end
  end
  
  describe "#attributes" do
    it "is expected to return a hash" do
      expect(subject.attributes).to be_kind_of(Hash)
    end

    it "is expected to have keys that relate to all the attributes" do
      expect(subject.attributes).to include('search_terms')
      expect(subject.attributes).to include('center')
      expect(subject.attributes).to include('description')
      expect(subject.attributes).to include('keywords')
      expect(subject.attributes).to include('location')
      expect(subject.attributes).to include('nasa_id')
      expect(subject.attributes).to include('title')
      expect(subject.attributes).to include('year_start')
      expect(subject.attributes).to include('year_end')
    end
  end
end