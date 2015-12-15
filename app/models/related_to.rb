class RelatedTo
  include Neo4j::ActiveRel

  from_class Person
  to_class Person
  type :RELATED_TO

  property :relation_type, type: String
end
