class Name 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :given, type: String
  property :surname, type: String
  # property :primary, type: Boolean, default: False

  def full_name
    self.given + " " + self.surname
  end

end
