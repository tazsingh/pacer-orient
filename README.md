# OrientDB Graph Database Adapter for Pacer

[OrientDB](http://http://www.orientechnologies.com/) is an excellent,
fast graph distribution. It's fully supported by
[Pacer](https://github.com/pangloss/pacer)'s standard graph features and
passes the full Pacer test suite.  This plugin also includes a default
property value encoder that takes advantage of Orient's unique ability
to support binary data, which may make Orient an excellent option for
projects which may store more complex or structured data within
properties on graph elements.

Pacer is built using [JRuby](http://jruby.org) on the excellent
[Tinkerpop](http://www.tinkerpop.com) stack.

## Usage

OrientDB has 3 modes of operation: embedded, embedded in memory, and
remote. All of them can be used independently or together and even
together with other graph adapters.

  require 'pacer'
  require 'pacer-orient'

  # Create or open a regular embedded local OrientDB graph
  graph1 = Pacer.orient 'path/to/graph'

  # Create a new in-memory graph
  graph2 = Pacer.orient

  # Connect to a remote graph.
  graph3 = Pacer.orient 'remote:localhost/graph', 'username', 'password'

All other operations are identical across graph implementations (except
where certain features are not supported). See Pacer's documentation for
more information.

## Further Work

* Wrap the Orient ID type to make it more useable
* Implement specialized index support similar to pacer-neo4j
* Implement support for Orient's SQL-like syntax (see pacer-neo4j's
  Cypher support)
* Orient-specific examples
