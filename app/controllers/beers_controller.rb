class BeersController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit]
  before_action :ensure_that_is_admin, only: :destroy

  def set_breweries_and_styles_for_template
	  @breweries = Brewery.all
  	  @styles = Style.all 
		  #@Style.all #["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
  end

  # GET /list
  def list
  end

  # GET /nglist
  def nglist
  end

  # GET /beers
  # GET /beers.json
  def index
	  @beers = Beer.all

	  order = params[:order] || 'name'

	  @beers = case order
		   when 'name' then @beers.sort_by{ |b| b.name }
		   when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
		   when 'style' then @beers.sort_by{ |b| b.style.name }
		   end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
	  @rating = Rating.new
	  @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
	set_breweries_and_styles_for_template
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style_id, :brewery_id)
      #Style.find_by name:params['beer']['style']
    end
end
