class Person 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps
  #property :names
  property :full_name
  property :birthday, type: Date
  property :occupation

  #serialize :names

  # p1.create_rel("related_to", p2, type: "ParentChild")
  #has_many :out, :related_to, type: :related_to, model_class: :Person
  #has_many :in, :people, type: :related_to

  has_many :both, :related_to, rel_class: :RelatedTo, unique: {on: :relation_type}
  has_many :out, :names, type: :NAMED
  has_many :both, :spouse, type: :MARRIED_TO, model_class: :Person
  has_many :out, :parents, type: :BORN_TO, model_class: :Person

  # p1.related_to(:n, :rel, rel_length: 2).query.unwind(r: :rel).with('DISTINCT r, n').where(r: { type: 'ParentChild' }).with('DISTINCT n').pluck(:n).each do |ppl|
  #   puts ppl.names["fullText"]
  # end
end
