require 'rails_helper'

describe "BeermappingApi" do

  describe "in case of cache miss" do

    before :each do
      Rails.cache.clear
    end

    it "When HTTP GET returns one entry, it is parsed and returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})

      places = BeermappingApi.places_in("espoo")

      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("Gallows Bird")
      expect(place.street).to eq("Merituulentie 30")
    end

  end

  describe "in case of cache hit" do

    it "When one entry in cache, it is returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})

      # ensure that data found in cache
      BeermappingApi.places_in("espoo")

      places = BeermappingApi.places_in("espoo")

      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("O'Connell's Irish Bar")
      expect(place.street).to eq("Rautatienkatu 24")
    end
  end

  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("espoo")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Gallows Bird")
    expect(place.street).to eq("Merituulentie 30")
  end


         it "When HTTP GET returns many entries, all are parsed and returned" do

        canned_answer = <<-END_OF_STRING
  <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12334</id><name>Rattaanpyörä</name><status>Olutbaari</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12334</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12334&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12334&amp;d=1&amp;type=norm</blogmap><street>Rautatienpuistokatu 25</street><city>Pori</city><state></state><zip>28100</zip><country>Finland</country><phone>358400131313</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18245</id><name>Beer Hunter's</name><status>Kaljabaari</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18845</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18845&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18845&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 13</street><city>Pori</city><state></state><zip>33300</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
        END_OF_STRING

        stub_request(:get, /.*pori/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

        places = BeermappingApi.places_in("pori")

        expect(places.size).to eq(2)
        place = places.first
  	place2 = places.second
        expect(place.name).to eq("Rattaanpyörä")
        expect(place.street).to eq("Rautatienpuistokatu 25")
        expect(place2.name).to eq("Beer Hunter's")
        expect(place2.street).to eq("Antinkatu 13")
      end

         it "When HTTP GET don't return entries, return empty" do

        canned_answer = <<-END_OF_STRING
  <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
        END_OF_STRING

        stub_request(:get, /.*pori/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

        places = BeermappingApi.places_in("pori")
        expect(places.size).to eq(0)
      end

      

end
