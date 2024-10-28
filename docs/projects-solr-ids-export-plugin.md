# Solr IdsExportPlugin

Solr Plugin I wrote when I worked for Allegro.

A plugin (to be more precise: set of plugins) for Solr allowing time-efficient export of Ids of all found documents (or
any DocValues-enabled field values) in comma-separated format without sorting. Lack of result sorting results in
significantly better performance then Solr build-in `/export` endpoint.

Link: [IdsExportPlugin](https://github.com/allegro/solr-ids-export-plugin)