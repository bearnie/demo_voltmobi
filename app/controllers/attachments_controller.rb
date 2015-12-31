class AttachmentsController < ApplicationController
  def create
    params[:attachments].each do |a_params|
      @attachment = Attachment.create(a_params)
    end
    respond_to do |format|
      if @attachment
        format.json { render json: @attachment.attributes.merge( stuff_url: url_for(@attachment) ) }
      else
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @id = @attachment.id
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render }
      format.json { head :no_content }
    end
  end
end
