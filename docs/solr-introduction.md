# Running Apache Solr locally

!!! info
    
    Assumptions:

     * using **Java 17**
     * using **MacOS** Ventura with **ZSH** (although everything should work in the same way on any Unix-like OS)
     * the working directory is `~/solr`
     * the Solr version is `9.1.0`
     * we're working on a **standalone** installation of Solr (not Solr Cloud)

## Download and unpack

Download and unpack zip file from [https://solr.apache.org/downloads.html](https://solr.apache.org/downloads.html)

You can use this script to do everything from the command line, although downloading
via browser is also fine

```shell
mkdir -p ~/solr
cd ~/solr

wget "https://www.apache.org/dyn/closer.lua/solr/solr/9.1.0/solr-9.1.0.tgz?action=download" -O solr-9.1.0.tgz

tar zxvf solr-9.1.0.tgz
cd solr-9.1.0
```

## Start and check status

```shell
./bin/solr start

./bin/solr status

less server/logs/solr.log
```

Open in the browser: [http://localhost:8983/](http://localhost:8983/)

![solr-no-cores.png](resources%2Fsolr%2Fsolr-no-cores.png)

## Create a core

!!! note "What is a core?"

    A `core` in Solr's terminology is a separate set of indexed data.
    
    For example: when you're running e-commerce, you might want to have a 
    separate core `users` for searching for usernames, and separate `products`
    for searching products you sell. Each core have a separate schema and configuration.

    If you're familiar with some SQL engines you should know a similar term from their
    world - a `database`. Just like a single deployment of SQL engine can keep a number of different kind
    of data in separate `databases` (MySQL command `USE dbname;`), Solr can hold a
    number of different kind of data in separate `cores`.

    **Note:** many people use the word `index` as a synonym for `core` - they will
    say that `users` and `products` from the example above are indexed in
    separate `indexes` (instead of `cores`). While this terminology makes some sense - 
    and in fact, it's even officially adopted in Elasticsearch - it's not strictly
    correct and you won't find it in the official Solr documentation. Probably
    the main reason is to have a clear conceptual separation between a `core` (set of data) and internal
    Lucene `index` (data structure).
    

```shell
./bin/solr create -c testcore
```
![solr-core-created.png](resources%2Fsolr%2Fsolr-core-created.png)

## Further reading

 * [https://solr.apache.org/guide/solr/latest/getting-started/introduction.html](https://solr.apache.org/guide/solr/latest/getting-started/introduction.html)