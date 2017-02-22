class BoitesController < ApplicationController
  before_action :set_boite, only: [:show, :edit, :update, :destroy]

  # GET /boites
  # GET /boites.json
  def index
   if params[:distance].present? && (params[:distance].to_i > 0)
      @search = Boite.near(params[:search], params[:distance] || 100).search(params[:q])
      @boites= @search.result.paginate(:page => params[:page], :per_page => 30)
      respond_to do |format|
        format.html
        format.xls { send_data @boites.to_csv(col_sep: "\t"), :filename => "Liste_boites.xls", :disposition => "attachment" }
      end
    else 
     @search = Boite.search(search_params)
     @boites = @search.result.paginate(:page => params[:page], :per_page => 30)

     #  @search.build_condition if @search.conditions.empty?
     @search.build_sort if @search.sorts.empty?
     respond_to do |format|
        format.html
        format.xls { send_data @search.result.to_csv(col_sep: "\t"), :filename => "Liste_boites.xls", :disposition => "attachment" }
      end
    end

  end

  # GET /boites/1
  # GET /boites/1.json
  def show
  end

  # GET /boites/new
  def new
    @boite = Boite.new
  end

  # GET /boites/1/edit
  def edit
  end

  # POST /boites
  # POST /boites.json
  def create
    @boite = Boite.new(boite_params)

    respond_to do |format|
      if @boite.save
        format.html { redirect_to @boite, notice: 'Boite was successfully created.' }
        format.json { render :show, status: :created, location: @boite }
      else
        format.html { render :new }
        format.json { render json: @boite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boites/1
  # PATCH/PUT /boites/1.json
  def update
    respond_to do |format|
      if @boite.update(boite_params)
        format.html { redirect_to @boite, notice: 'Boite was successfully updated.' }
        format.json { render :show, status: :ok, location: @boite }
      else
        format.html { render :edit }
        format.json { render json: @boite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boites/1
  # DELETE /boites/1.json
  def destroy
    @boite.destroy
    respond_to do |format|
      format.html { redirect_to boites_url, notice: 'Boite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 # CHECK THE SESSION FOR SEARCH PARAMETERS IS THEY AREN'T IN THE REQUEST
    def search_params
      if params[:q] == nil
          params[:q] = session[search_key]
      end
      if params[:q]
            session[search_key] = params[:q]
          end
          params[:q]
    end
    # DELETE SEARCH PARAMETERS FROM THE SESSION
    def clear_search_index
        if params[:search_cancel]
          params.delete(:search_cancel)
          if(!search_params.nil?)
              search_params.each do |key, param|
                  search_params[key] = nil
              end
          end
          # REMOVE FROM SESSION
          session.delete(search_key)
        end
    end
 
  protected
    # GENERATE A GENERIC SESSION KEY BASED ON TEH CONTROLLER NAME
    def search_key
      "#{location}_search".to_sym
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boite
      @boite = Boite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boite_params
      params.require(:boite).permit(:departement, :zip, :commune, :boite, :latitude, :longitude)
    end
end
