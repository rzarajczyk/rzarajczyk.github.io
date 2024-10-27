# Solr querying

## Docs and sources:

* [Query Syntax and Parsers](https://solr.apache.org/guide/solr/latest/query-guide/query-syntax-and-parsers.html)
* [Common Query Parameters](https://solr.apache.org/guide/solr/latest/query-guide/common-query-parameters.html)

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
