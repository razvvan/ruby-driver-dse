# encoding: utf-8

#--
# Copyright 2013-2016 DataStax, Inc.
#++

module Dse
  module Graph
    # Path represents a path connecting a set of vertices.
    class Path
      # @return [Array<Array>] labels in the path
      attr_reader :labels
      # @return [Array<Vertex, Edge, Result>] objects in the path, coerced to domain objects that
      #   we recognize, or a {Result} otherwise
      attr_reader :objects

      # @private
      def initialize(labels, objects)
        @labels = labels
        @objects = objects.map do |o|
          Result.new(o).cast
        end
      end

      # @private
      def eql?(other)
        other.is_a?(Path) && \
        @labels == other.labels && \
        @objects == other.objects
      end

      # @private
      def hash
        # id's are unique among graph objects, so we only need to hash on the id for safely adding to a hash/set.
        @hash ||= begin
          h = 17
          h = 31 * h + @labels.hash
          h = 31 * h + @objects.hash
          h
        end
      end

      # @private
      def inspect
        "#<Dse::Graph::Path:0x#{object_id.to_s(16)} " \
          "@labels=#{labels.inspect}, " \
          "@objects=#{@objects.inspect}>"
      end
    end
  end
end
