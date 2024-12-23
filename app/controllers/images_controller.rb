class ImagesController < ApplicationController
  before_action :set_batch

  # DELETE /batches/1
  def destroy
    @image = @batch.images.find(params[:id])
    @image.destroy!
    redirect_to batch_path(@batch), notice: "Image was successfully destroyed.", status: :see_other
  end

  private
    def set_batch
      @batch = Batch.find(params[:batch_id])
    end
end
