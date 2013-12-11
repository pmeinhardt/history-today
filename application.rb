require "./environment"

configure do
  set :json_encoder, JSON
end

get "/" do
  erb :index
end

get "/today.json" do
  sparql = SPARQL::Client.new("http://live.dbpedia.org/sparql")
  # or: sparql = SPARQL::Client.new("http://dbpedia.org/sparql")

  offset = params[:offset] || 0

  rows = sparql.query(%{
    PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX dbp:  <http://dbpedia.org/resource/>
    PREFIX dbo:  <http://dbpedia.org/ontology/>
    PREFIX dbpp: <http://dbpedia.org/property/>
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>

    SELECT DISTINCT *
    WHERE {
      ?prop rdf:type owl:DatatypeProperty ;
        rdfs:domain ?domain ;
        rdfs:range xsd:date .

      OPTIONAL {
        ?prop rdfs:label ?label .
        FILTER (lang(?label) = "en") .
      }

      ?subject rdfs:subClassOf*/rdf:type ?domain ;
        ?prop ?date .

      FILTER (bif:substring(str(?date), 6, 5) = bif:substring(str(now()), 6, 5))

      OPTIONAL {
        ?subject rdfs:label ?name ;
          foaf:isPrimaryTopicOf ?article .

        FILTER (lang(?name) = "en")
      }
    }
    OFFSET #{offset}
    LIMIT 100
  })

  results = rows.map { |r| r.to_hash }

  json results
end
