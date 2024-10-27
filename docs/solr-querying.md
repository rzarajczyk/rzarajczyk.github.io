# Solr querying

## Docs and sources:

* [Query Syntax and Parsers](https://solr.apache.org/guide/solr/latest/query-guide/query-syntax-and-parsers.html)
* [Common Query Parameters](https://solr.apache.org/guide/solr/latest/query-guide/common-query-parameters.html)
* [Standard Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/standard-query-parser.html)
* [DixMax Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html)
* [Extended DisMax (eDisMax) Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/edismax-query-parser.html)

## How do send queries to Solr?`

Basic example:

=== "HTTP API"

    ```shell
    curl "http://localhost:8983/solr/mycore/select?q=*:*"
    ```

=== "SolrUI"

    ![solr-10.png](resources/solr-10.png)

### About QueryParsers

The query syntax is strictly dependent on the QueryParser being used. Each parser has different syntax and capabilities.

### Common query parameters

Full list and
description: [Common Query Parameters](https://solr.apache.org/guide/solr/latest/query-guide/common-query-parameters.html)

Some examples:

| param         | description                                                           | examples                                                                                                     | defaultValue |
|---------------|-----------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|--------------|
| `defType`     | which QueryParser should be used                                      | <ul><li>`dismax`</li><li>`edismax`</li><li>`lucene`</li></ul>                                                | `lucene`     |
| `q`           | main query                                                            | _depending on QueryParser_                                                                                   | _none_       | 
| `fq`          | filter query                                                          | `fq=popularity:[10 TO *]&fq=section:0`                                                                       | _none_       |
| `sort`        | result set sorting order                                              | <ul><li>`score desc`</li><li>`price asc, name desc`</li><li>`price asc, div(popularity,price) asc`</li></ul> | `score desc` |
| `start`       | for pagination: offset of page start                                  | `0`                                                                                                          | `0`          | 
| `rows`        | for pagination: number of documents                                   | `72`                                                                                                         | `10`         |
| `fl`          | fields to retrieve                                                    | <ul><li>`id,name,price`</li><li>`id na* price`</li><li>`*`</li><li>`div(popularity,price)`</li></ul>         | `*`          |
| `debug`       | return debug information                                              | <ul><li>`query`</li><li>`timing`</li><li>`results`</li><li>`all`</li></ul>                                   | _none_       |
| `timeAllowed` | the amount of time, in milliseconds, allowed for a search to complete | 2000                                                                                                         | _none_       |
| `wt`          | output format                                                         | <ul><li>`json`</li><li>`xml`</li><li>`csv`</li></ul>                                                         | `json`       |
| `echoParams`  | should the query parameters be included in the response               | <ul><li>`all`</li><li>`none`</li><li>`explicit`</li></ul>                                                    | `none`       |

Additionally, you can specify:

* [Faceting](https://solr.apache.org/guide/solr/latest/query-guide/faceting.html)
* [Highlighting](https://solr.apache.org/guide/solr/latest/query-guide/highlighting.html)

---

### Lucene Query Parser (default)

Example:

```shell
curl "http://localhost:8983/solr/mycore/select?defType=lucene&q=*:*"
```

Docs: [Standard Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/standard-query-parser.html)

| param  | description                                         | defaultValue |
|--------|-----------------------------------------------------|--------------|
| `q`    | main query (mandatory); see examples below          | _none_       | 
| `q.op` | `AND` or `OR`, relation between tokens              | `OR`         | 
| `df`   | which (single) field should be searched, eg. `name` | _none_       |

The main query syntax by example:

* `vw golf` - searches for these words in fields defined in `df`, and joins them using `q.op`
* `"vw golf"` - quotes mark phrases. Tokens must be next to each other.
* `gol?`, `gol*` - wildcards are supported
* `golf~2` - tilde after word (not phrase) - fuzzy searching, finds similar words
* `"vw golf"~3` - tilde after phrase (not word) - proximity search, tokens `vw` and `golf` must be within 3 words of
  each other
* `name:vw` - possibility to define explicit fields - `<field-name>:<query>`
* `name:"vw golf"`, `name:gol?`, `name:gol*`, `name:golf~2` - it's all supported
* `name:*` - finds documents, which have some value in field `name` set
* `price:[52 TO 1000]` - ranges for numeric fields (including those borders)
* `price:{52 TO 1000}` - ranges for numeric fields (EXCLUDING those borders)
* `price:{52 TO 1000]`, `price:[* TO 1000]` - also possible
* `vw^4 golf` - boosting; token `vw` is boosted (more important) four times
* `vw OR golf`, `vw AND golf`, `vw || golf`, `vw && golf` - explicitly specify operator between tokens
* `"vw golf" OR toyota` - also possible
* `(vw AND golf) OR toyota` - also possible
* `vw NOT golf`, `vw ! golf` - excluding tokens
* `+vw -golf` - must include `vw`, cannot include `golf`

### DisMax

Example:

```shell
curl "http://localhost:8983/solr/mycore/select?defType=dismax&q=vw+golf&qf=brand^2+model"
```

The main goal of DisMax was to separate the user's query from how the query should be processed. DisMax doesn't support
Lucene Query Parser's syntax!

Docs: [DixMax Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html)

| param   | description                                                                                                                                                                                                                                                         | defaultValue |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| `q`     | main query (mandatory): only basic syntax is supported: <ul><li>quotes for phrases</li><li>SHOULD MATCH: just _word_ without any modifier (default)</li><li>MUST MATCH: _+word_ (prefix `+`)</li><li>CAN'T MATCH: _-word_ (prefix `-`)</li></ul> see examples below | _none_       | 
| `q.alt` | query which should be used if main query is empty                                                                                                                                                                                                                   | _none_       | 
| `qf`    | which fields should be searched with their weights, eg. `brand^2.5 model^0.5`                                                                                                                                                                                       | _none_       |
| `mm`    | minimum should match; number of SHOULD MATCH words that must match the document; might be absolute or percentage                                                                                                                                                    | _none_       |
| `pf`    | phrase fields; if the tokens appear in close proximity in this field, the document is boosted, eg `title^4 description^1`                                                                                                                                           | _none_       |
| `ps`    | phrase slop; the maximum distance between tokens to form a phrase                                                                                                                                                                                                   | _none_       |
| `tie`   | tie breaker: see [the docs](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html#the-tie-tie-breaker-parameter)                                                                                                                                | _none_       |
| `bq`    | boost query: see [the docs](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html#bq-boost-query-parameter)                                                                                                                                | _none_       |
| `bf`    | boost function: see [the docs](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html#bf-boost-functions-parameter)                                                                                                                         | _none_       |

The main query syntax by example:

* `q=vw golf&qf=brand^2 model` - search for words `vw` (optional) and `golf` (optional) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw golf&qf=brand^2 model` - search for words `vw` (mandatory) and `golf` (optional) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+"vw golf"&qf=brand^2 model` - search for phrase `"vw golf"` (mandatory) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw +golf&qf=brand^2 model` - search for words `vw` (mandatory) and `golf` (mandatory) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw +golf -toyota&qf=brand^2 model` - search for words `vw` (mandatory) and `golf` (mandatory) in fields `brand` (
  higher priority) and `name` (lower priority); documents cannot contain `toyota`
* `q=vw golf hatchback&qf=brand^2 model&mm=2` - search for words `vw` (optional) and `golf` (optional) and
  `hatchback` (optional) in fields `brand` (higher priority) and `name` (lower
  priority); the document is returned if at least two of these optional words have been found
* `q=vw golf hatchback&qf=brand^2 model&mm=50%` - search for words `vw` (optional) and `golf` (optional) and
  `hatchback` (optional) in fields `brand` (higher priority) and `name` (lower
  priority); the document is returned if at least half of the optional words have been found 
* `q=vw golf&qf=brand^2 model&pf=name^5` - search for words `vw` (optional) and `golf` (optional) in fields `brand` (
  higher priority) and `name` (lower priority); if the phrase "vw golf" if found in field `name`, boost the document
* `q=vw golf&qf=brand^2 model&pf=name^5&ps=4` - search for words `vw` (optional) and `golf` (optional) in fields
  `brand` (higher priority) and `name` (lower priority); if the phrase "vw golf" if found in field `name`, boost the
  document; maximum allowed distance between these words is 4

### eDisMax

Example:

```shell
curl "http://localhost:8983/solr/mycore/select?defType=edismax&q=vw+AND+golf&qf=brand^2+model"
```

Extended DisMax, combination DisMax and Lucene Query Parser with add-ons.

As a first approximation, you can think of eDixMax as DisMax, where:

* you can use `AND` and `OR` inside `q` parameter
* you can specify a `boost` function in a better way than in DisMax
* have some additional enhancements

For better understanding, refer to the
docs: [Extended DisMax (eDisMax) Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/edismax-query-parser.html)