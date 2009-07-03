class CmsAdmin::AttachmentsController < CmsAdmin::BaseController
  
  before_filter :load_attachment, :only => [:edit, :update, :destroy]
  
  def index
    @attachments = CmsAttachment.all
  end
  
  def new
    @attachment = CmsAttachment.new
  end
  
  def edit
  end
  
  def create
    @attachment = CmsAttachment.new(params[:attachment])
    if @attachment.save
      flash[:notice] = 'Attachment created'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  def update
    if @attachment.update_attributes(params[:attachment])
      flash[:notice] = 'Attachment updated'
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    @attachment.destroy
    
    flash[:notice] = 'Attachment removed'
    redirect_to :action => :index
  end
  
protected

  def load_attachment
    @attachment = CmsAttachment.find_by_id(params[:id])
  end
  
end