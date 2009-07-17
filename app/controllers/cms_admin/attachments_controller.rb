class CmsAdmin::AttachmentsController < CmsAdmin::BaseController
  
  before_filter :load_attachment, :only => [:edit, :update, :destroy]
  
  def index
    @cms_attachments = CmsAttachment.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def new
    @cms_attachment = CmsAttachment.new
  end
  
  def edit
  end
  
  def create
    @cms_attachment = CmsAttachment.new(params[:cms_attachment])
    @cms_attachment.save!
    
    flash[:notice] = 'Attachment created'
    redirect_to :action => :edit, :id => @cms_attachment
  
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @cms_attachment.update_attributes!(params[:cms_attachment])
    
    flash[:notice] = 'Attachment updated'
    redirect_to :action => :edit, :id => @cms_attachment
  
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @cms_attachment.destroy
    
    flash[:notice] = 'Attachment removed'
    redirect_to :action => :index
  end
  
protected

  def load_attachment
    @cms_attachment = CmsAttachment.find_by_id(params[:id])
  end
  
end