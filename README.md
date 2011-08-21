# OrientDB Graph Database Adapter for Pacer

*Note:* The Pacer test suite does not pass with this graph adapter,
therefore this adapter is currently only experimental. Graphs with fully
passing test suites currently include TinkerGraph, Neo4j and Dex.

[Pacer](https://github.com/pangloss/pacer) is a
[JRuby](http://jruby.org) graph traversal framework built on the
[Tinkerpop](http://www.tinkerpop.com) stack.

This plugin enables full
[OrientDB](http://http://www.orientechnologies.com/) graph support in Pacer.


## Usage

Here is how you open a OrientDB graph in Pacer.

  require 'pacer'
  require 'pacer-orient'

  # Graph takes an OrientDB URL, e.g. disk back graph:
  graph = Pacer.orient 'local:path/to/graph'

  # In memory graph
  graph = Pacer.orient 'memory:foo'

  # Remote graph
  graph = Pacer.orient 'remote:localhost/graph', 'username', 'password'

All other operations are identical across graph implementations (except
where certain features are not supported). See Pacer's documentation for
more information.

