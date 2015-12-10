class Person 
  include Neo4j::ActiveNode
  property :names

  serialize :names

  # p1.create_rel("related_to", p2, type: "ParentChild")
  has_many :out, :related_to, type: :related_to, model_class: :Person
  has_many :in, :people, type: :related_to
end
