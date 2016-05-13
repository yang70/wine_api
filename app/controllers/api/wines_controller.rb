module API
  class WinesController < ApplicationController
    before_action :set_wine, only: [:show, :update, :destroy]

    # GET /wines
    # GET /wines.json
    def index
      @wines = Wine.all

      render json: @wines
    end

    # GET /wines/1
    # GET /wines/1.json
    def show
      render json: @wine
    end

    # POST /wines
    # POST /wines.json
    def create
      @wine = Wine.new(wine_params)

      if @wine.save
        render json: @wine, status: :created
      else
        render json: @wine.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /wines/1
    # PATCH/PUT /wines/1.json
    def update
      @wine = Wine.find(params[:id])

      if @wine.update(wine_params)
        render json: @wine, status: 200
      else
        render json: @wine.errors, status: :unprocessable_entity
      end
    end

    # DELETE /wines/1
    # DELETE /wines/1.json
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
