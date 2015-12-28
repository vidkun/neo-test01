class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @name = Name.new
  end

  # GET /people/1/edit
  def edit
    @name = Name.new
  end

  # POST /people
  # POST /people.json
  def create
    console
    @person = Person.new(person_params.except(:name, :spouse, :parents))
    unless (person_params[:name][:given].nil? || person_params[:name][:given] == "")
      name = Name.create(given: person_params[:name][:given], surname: person_params[:name][:surname])
      @person.names << name
    end
    unless (person_params[:spouse] == "")
      spouse = Person.where(id: person_params[:spouse]).first
      @person.spouse << spouse
    end
    unless (person_params[:parents[1]] == "")
      parent_1 = Person.where(id: person_params[:parents[1]]).first
      @person.parents << parent_1
    end
    unless (person_params[:parents[2]] == "")
      parent_2 = Person.where(id: person_params[:parents[2]]).first
      @person.parents << parent_2
    end
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    unless (person_params[:name][:given].nil? || person_params[:name][:given] == "")
      name = Name.create(given: person_params[:name][:given], surname: person_params[:name][:surname])
      @person.names << name
    end
    unless (person_params[:spouse] == "")
      spouse = Person.where(id: person_params[:spouse]).first
      @person.spouse << spouse
    end
    unless (person_params[:parents[0]] == "")
      parent_1 = Person.where(id: person_params[:parents[0]]).first
      @person.parents << parent_1
    end
    unless (person_params[:parents[1]] == "")
      parent_2 = Person.where(id: person_params[:parents[1]]).first
      @person.parents << parent_2
    end
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:full_name,
                                     :birthday,
                                     :occupation,
                                     {name: [:given, :surname]},
                                     :spouse,
                                     :parent_1,
                                     :parent_2,
                                     :parents)
    end
end
