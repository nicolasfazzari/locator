class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  
  # GET /locations
  # GET /locations.json

  def index
  
   if params[:distance].present? && (params[:distance].to_i > 0)
      @search = Location.near(params[:search], params[:distance] || 100).search(params[:q])
      @locations = @search.result.paginate(:page => params[:page], :per_page => 30)
      respond_to do |format|
        format.html
        format.xls { send_data @locations.to_csv(col_sep: "\t"), :filename => "Liste_boulangeries.xls", :disposition => "attachment" }
      end
    else 
     @search = Location.search(search_params)
     @locations = @search.result.paginate(:page => params[:page], :per_page => 30)

     #  @search.build_condition if @search.conditions.empty?
     @search.build_sort if @search.sorts.empty?
     respond_to do |format|
        format.html
        format.xls { send_data @search.result.to_csv(col_sep: "\t"), :filename => "Liste_boulangeries.xls", :disposition => "attachment" }
      end
    end

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location= Location.find(params[:id])
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.name
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
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
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :zip, :city, :latitude, :longitude, :phone, :name)
    end

    
end
