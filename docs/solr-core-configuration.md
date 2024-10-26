# Solr core configuration

## Docs:

## File structure of a `core/conf` directory

```shell
rafal@MacBook-Pro-Rafal solr-9.7.0 % ls -l server/solr/mycore/conf
total 108
drwxr-xr-x 41 rafal staff  1312 Sep  4 00:06 lang
-rw-r--r--  1 rafal staff 50695 Sep  4 00:06 managed-schema.xml
-rw-r--r--  1 rafal staff   873 Sep  4 00:06 protwords.txt
-rw-r--r--  1 rafal staff 44800 Sep  4 00:06 solrconfig.xml
-rw-r--r--  1 rafal staff   781 Sep  4 00:06 stopwords.txt
-rw-r--r--  1 rafal staff  1124 Sep  4 00:06 synonyms.txt
```

Most important files:
* `solrconfig.xml` - configuration of the core, for example:
    * defining handlers (`/select` for searching, `/update` for indexing), query parsers, etc
    * adding plugins
    * merge policy
    * replication
    * see [docs](https://solr.apache.org/guide/solr/latest/configuration-guide/configuring-solrconfig-xml.html)
* `managed-schema.xml` - schema of the data. Previously known as `schema.xml`