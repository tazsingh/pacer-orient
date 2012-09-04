require 'yaml'

module Pacer
  class << self
    # Return a graph for the given path. Will create a graph if none exists at
    # that location. (The graph is only created if data is actually added to it).
    def orient(url, username = nil, password = nil)
      orient = com.tinkerpop.blueprints.pgm.impls.orientdb.OrientGraph
      open = proc do
        graph = Pacer.open_graphs[[url, username]]
        unless graph
          if username
            graph = orient.new(url, username, password)
          else
            graph = orient.new(url)
          end
          Pacer.open_graphs[path] = graph
        end
        graph
      end
      shutdown = proc do |g|
        g.blueprints_graph.shutdown
        Pacer.open_graphs[[url, username]] = nil
      end
      PacerGraph.new(Pacer::YamlEncoder, open, shutdown)
    end
  end
end
