module CmsCommon::RenderPage
  def render_page(options = { })
    # REFACTOR AND CLEANUP REQUIRED
    @cms_page_preview_mode = options[:preview]
    
    # Rendering 404 page
    if !@cms_page
      @cms_page = CmsPage.published.find_by_full_path('404')

      if @cms_page
        render :inline => @cms_page.content, :layout => (@cms_page.cms_layout.app_layout || false), :status => 404
      else
        render :text => '404 Page Not Found', :status => 404
      end
      return
    end
    
    respond_to do |format|
      format.html do
        if @cms_page.redirect_to_page
          redirect_to @cms_page.redirect_to_page.full_path
        else
          layout = (@cms_page.cms_layout.app_layout || false)
          
          if Rails.env.development? || Rails.env.test?
            # attempt to load content from the filesystem first
            begin
              @cms_page_slug = @cms_page_slug.blank? ? 'index' : @cms_page_slug
              render :template => "/cms/#{@cms_page_slug}", :layout => layout
              return
            rescue ActionView::MissingTemplate ; end
          end
          
          render :inline => @cms_page.content, :layout => layout
        end
      end

      format.xml do
        @cms_page_children = @cms_page.children[0...25].collect do |p|
          p.rendered_content = render_to_string(:inline => p.content, :layout => false)
          p
        end
      end
    end
  end
end
