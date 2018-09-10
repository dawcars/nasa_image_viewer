# NASA Image Viewer

This application provides search facilities for the NASA image library using the [NASA image API](https://api.nasa.gov/api.html#Images). Documentation for the NASA image API is available here: [https://images.nasa.gov/docs/images.nasa.gov_api_docs.pdf](https://images.nasa.gov/docs/images.nasa.gov_api_docs.pdf)

Technology
----------
The application uses:
* Ruby 2.5.1
* Rails 5.2.1
* sqlite3

Performing A Search
-------------------
It is possible to search using the following query parameters:

* **search_terms** - Free text search terms to compare to all indexed metadata.
  * '__mars__', '__rover__', '__apollo 11__'

* **center** - NASA center which published the media.
  * Information about NASA centers can be found here: [https://en.wikipedia.org/wiki/NASA_facilities](https://en.wikipedia.org/wiki/NASA_facilities)
  * '__JPL__', '__KSC__', '__JSC__'

* **description** - Terms to search for in “Description” fields.
  * '__surface__', '__jupiter__', '__milky way__'

* **keywords** - Terms to search for in “Keywords” fields. Separate multiple values with commas.
  * '__supernova__'

* **location** - Terms to search for in “Location” fields.
  * '__kennedy__'

* **nasa_id** - The media asset’s NASA ID.
  * '__GSFC_20171208_Archive_e000717__'

* **title** - Terms to search for in “Title” fields.
  * '__Galaxy mission__'

* **year_start** - The start year for results. Format: YYYY.
  * '__1964__'

* **year_end** - The end year for results. Format: YYYY.
  * '__2018__'


Created By
-----------
Application developed by [Carol Dawson](https://github.com/dawcars)

Images and API 
--------------
&copy; Copyright [NASA](https://api.nasa.gov/api.html#Images)







