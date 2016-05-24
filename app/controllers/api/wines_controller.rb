module API
  class WinesController < ApplicationController
    before_filter :authenticate_request!
    load_and_authorize_resource

    # GET /wines
    def index
      # authorize! :read, Wine
      render json: @wines
    end

    # GET /wines/1
    def show
      # authorize! :show, @wine
      render json: @wine
    end

    # POST /wines
    def create
      @wine.user = current_user

      if @wine.save
        render json: @wine, status: :created
      else
        render json: @wine.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /wines/1
    def update

      if @wine.update(wine_params)
        render json: @wine, status: 200
      else
        render json: @wine.errors, status: :unprocessable_entity
      end
    end

    # DELETE /wines/1
    def destroy
      @wine.destroy

      head :no_content
    end

    private

    def set_wine
      @wine = Wine.find(params[:id])
    end

    def wine_params
      params.require(:wine).permit(:name, :varietal, :quantity)
    end
  end
end
