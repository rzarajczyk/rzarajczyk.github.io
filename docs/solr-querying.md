# Solr querying

## Docs and sources:

* [Query Syntax and Parsers](https://solr.apache.org/guide/solr/latest/query-guide/query-syntax-and-parsers.html)
* [Common Query Parameters](https://solr.apache.org/guide/solr/latest/query-guide/common-query-parameters.html)
* [Standard Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/standard-query-parser.html)
* [DixMax Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html)
* [Extended DisMax (eDisMax) Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/edismax-query-parser.html)

## How do send queries to Solr?`

Basic example:

```shell
curl "http://localhost:8983/solr/mycore/select?q=*:*"
```

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

These parameters can be also set in the SolrUI

![solr-10.png](resources/solr-10.png)

### Lucene Query Parser (Standard)

Docs: [Standard Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/standard-query-parser.html)

| param  | description                                         | defaultValue |
|--------|-----------------------------------------------------|--------------|
| `q`    | main query (mandatory)                              | _none_       | 
| `q.op` | `AND` or `OR`, relation between tokens              | `OR`         | 
| `df`   | which (single) field should be searched, eg. `name` | _none_       |

The main query syntax by example:

* `vw golf` - searches for these words in fields defined in `df`, and joins them using `q.op`
* `"vw golf"` - searches for phrase in fields defined in `df`. Tokens must be next to each other.
* `gol?`, `gol*` - wildcards are supported
* `golf~2` - fuzzy searching, finds similar words
* `"vw golf"~3` - proximity search, tokens `vw` and `golf` must be within 3 words of each other
* `name:vw` - searches for `vw` in field `name`
* `name:"vw golf"` - searches for phrase `"vw golf"` in field `name`
* `name:gol?`, `name:gol*`, `name:golf~2` - it's all supported
* `name:*` - finds documents, which have some value in field `name` set
* `price:[52 TO 1000]` - ranges for numeric fields (including those borders)
* `price:{52 TO 1000}` - ranges for numeric fields (EXCLUDING those borders)
* `price:{52 TO 1000]` - also possible
* `price:[* TO 1000]` - also possible
* `vw^4 golf` - token `vw` if boosted (more important) four times
* `vw OR golf`, `vw AND golf`, `vw || golf`, `vw && golf` - explicitly specify operator between tokens
* `"vw golf" OR toyota` - also possible
* `(vw AND golf) OR toyota` - also possible
* `vw NOT golf`, `vw ! golf` - also possible
* `+vw -golf` - must include `vw`, cannot include `golf`

### DisMax

Docs: [DixMax Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/dismax-query-parser.html)

The main goal of DisMax was to separate the user's query from how the query should be processed.

**Note:** DisMax doesn't support Lucene Query Parser's syntax!

| param | description                                                                                                  | defaultValue |
|-------|--------------------------------------------------------------------------------------------------------------|--------------|
| `q`   | main query (mandatory)                                                                                       | _none_       | 
| `qf`  | which fields should be searched + their weights, eg. `brand^4.5 model`                                       | _none_       |
| `mm`  | minimum should match; number of "should" words that must match the document; might be absolute or percentage | _none_       |
| `pf`  | phrase fields; if the tokens appear in close proximity in this field, the document is boosted                | _none_       |
| `ps`  | phrase slop; the maximum distance between tokens to form a phrase                                            | _none_       |

The main query syntax by example:

* `q=vw golf&qf=brand^2 model` - search for tokens `vw` (optional) and `golf` (optional) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw golf&qf=brand^2 model` - search for tokens `vw` (mandatory) and `golf` (optional) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw +golf&qf=brand^2 model` - search for tokens `vw` (mandatory) and `golf` (mandatory) in fields `brand` (higher
  priority) and `name` (lower priority)
* `q=+vw +golf -toyota&qf=brand^2 model` - search for tokens `vw` (mandatory) and `golf` (mandatory) in fields `brand` (
  higher priority) and `name` (lower priority); documents cannot contain `toyota`
* `q=vw golf hatchback&qf=brand^2 model&mm=2` - search for tokens `vw` (optional) and `golf` (optional) and
  `hatchback` (optional) in fields `brand` (higher priority) and `name` (lower
  priority); the document is returned if at least two of these optional words have been found
* `q=vw golf&qf=brand^2 model&pf=name` - search for tokens `vw` (optional) and `golf` (optional) in fields `brand` (
  higher
  priority) and `name` (lower priority); if the phrase "vw golf" if found in field `name`, boost the document
* `q=vw golf&qf=brand^2 model&pf=name&ps=4` - search for tokens `vw` (optional) and `golf` (optional) in fields
  `brand` (higher
  priority) and `name` (lower priority); if the phrase "vw golf" if found in field `name`, boost the document; maximum
  allowed distance between these words is 4

### eDisMax

Combination of Lucene and DisMax. See the docs: [Extended DisMax (eDisMax) Query Parser](https://solr.apache.org/guide/solr/latest/query-guide/edismax-query-parser.html)