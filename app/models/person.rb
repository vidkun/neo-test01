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
  has_one :out, :gender, type: :IS_A, model_class: :Gender

  # p1.related_to(:n, :rel, rel_length: 2).query.unwind(r: :rel).with('DISTINCT r, n').where(r: { type: 'ParentChild' }).with('DISTINCT n').pluck(:n).each do |ppl|
  #   puts ppl.names["fullText"]
  # end

  def add_name (name)
    unless (name[:given].nil? || name[:given] == "") && (name[:surname].nil? || name[:surname] == "")
      self.names << Name.create(given: name[:given], surname: name[:surname])
    end
  end

  def add_spouse (spouse)
    unless (spouse.nil? || spouse == "")
      self.spouse << Person.find(spouse)
    end
  end

  def set_gender (gender)
    unless (gender.nil? || gender == "")
      self.gender << Gender.find(gender)
    end
  end

  def add_parents (parents)
    unless (parents.nil? || parents == "")
      parents.each do |parent|
        next if parent == "" || parent.nil
        self.parents << Person.find(parent)
      end
    end
  end
end
