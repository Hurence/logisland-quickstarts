curl "http://localhost:8983/solr/admin/collections?action=CREATE&name=historian&numShards=2&replicationFactor=1"


curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field-type" : {
     "name":"ngramtext",
     "class":"solr.TextField",
     "positionIncrementGap":"100",
     "indexAnalyzer" : {
        "tokenizer":{
           "class":"solr.NGramTokenizerFactory",
           "minGramSize":"2",
           "maxGramSize":"5"  },
        "filters":[{
           "class":"solr.LowerCaseFilterFactory" }]
      },
      "queryAnalyzer" : {
       "type": "query",
        "tokenizer":{
           "class":"solr.StandardTokenizerFactory" },
        "filters":[{
           "class":"solr.LowerCaseFilterFactory" }]
      }
    }
}' http://localhost:8983/solr/historian/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{ "name":"chunk_start", "type":"plong" },
  "add-field":{ "name":"chunk_end",   "type":"plong"},
  "add-field":{ "name":"chunk_value",  "type":"binary" },
  "add-field":{ "name":"chunk_avg",  "type":"pdouble"  },
  "add-field":{ "name":"chunk_size_bytes",  "type":"pint" },
  "add-field":{ "name":"chunk_size",  "type":"pint" },
  "add-field":{ "name":"chunk_min",  "type":"pdouble" },
  "add-field":{ "name":"chunk_max",  "type":"pdouble" },
  "add-field":{ "name":"chunk_sax",  "type":"ngramtext" },
  "add-field":{ "name":"chunk_trend",  "type":"boolean"},
  "add-field":{ "name":"chunk_window_ms",  "type":"plong" },  
  "add-field":{ "name":"tagname",  "type":"text" },
  "add-field":{ "name":"quality",  "type":"pfloat" }
}' http://localhost:8983/solr/historian/schema
