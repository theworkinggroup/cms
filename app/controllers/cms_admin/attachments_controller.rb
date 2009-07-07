class CmsAdmin::AttachmentsController < CmsAdmin::BaseController
  
  before_filter :load_attachment, :only => [:edit, :update, :destroy]
  
  def index
    @attachments = CmsAttachment.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def new
    # ...
  end
  
  def edit
    # ...
  end
  
  def create
    @attachment = CmsAttachment.new(params[:attachment])
    @attachment.save!
    
    flash[:notice] = 'Attachment created'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @attachment.update_attributes!(params[:attachment])
    
    flash[:notice] = 'Attachment updated'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
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