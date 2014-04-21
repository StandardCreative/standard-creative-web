class ThingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_thing, only: [:destroy]

  # POST /things
  # POST /things.json
  def create
    @thing = Thing.new(thing_params.merge(user: current_user))

    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'thing was successfully created.' }
        format.json { render :show, status: :created, location: @thing }
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to things_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = current_user.things.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:project_id, :hash, :filename)
    end
end
