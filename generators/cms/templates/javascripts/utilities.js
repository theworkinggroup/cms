function slugify(str) {
  str = str.replace(/^\s+|\s+$/g, '');
  var from = "ÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛàáäâèéëêìíïîòóöôùúüûÑñÇç·/_,:;";
  var to   = "aaaaeeeeiiiioooouuuuaaaaeeeeiiiioooouuuunncc------";
  for (var i=0, l=from.length ; i<l ; i++) {
    str = str.replace(new RegExp(from[i], "g"), to[i]);
  }
  str = str.replace(/[^a-zA-Z0-9 -]/g, '').replace(/\s+/g, '-').toLowerCase();
  return str;
}

$(document).ready(function() {
  current_path = window.location.pathname
  
  // Expand/Collapse tree function
  $('a.tree_toggle').bind('click.cms', function() {
    $(this).siblings('ul').toggle();
    $(this).toggleClass('closed');
    // oject_id are set in the helper (check cms_helper.rb)
    $.ajax({url: [current_path, object_id, 'toggle'].join('/')});
  })
  
  // Show/hide details
  $('a.details_toggle').bind('click.cms', function() {
    $(this).parent().siblings('table.details').toggle();
  })

  // Sortable trees
  $('ul.sortable').each(function(){
    $(this).sortable({  handle: 'div.dragger', 
                        update: function() {
                          $.post(current_path + '/reorder', '_method=put&'+$(this).sortable('serialize'));
                        } 
    })
  })
  
  // Slugify fields
  $('input#slugify').bind('keyup.cms', function() {
    $('input#slug').val(slugify($(this).val()))
  })
  
  // Setting form targets
  $('input#save').bind('click.cms', function() {
    $(this).parents('form:first').attr('target', '')
  })
  
  $('input#preview').bind('click.cms', function() {
    $(this).parents('form:first').attr('target', '_blank')
  })
  
  $('select#cms_page_cms_layout_id').bind('change.cms', function() {
    // Remove all existing ckeditor instances first
    try { 
      $('textarea.richText').ckeditorGet().destroy(); } 
    catch(e) {}
    $.ajax({url: ['/cms-admin/pages', page_id, 'form_blocks'].join('/'), data: ({ layout_id: $(this).val()})})
  })
  
  $('a#more_options').bind('click.cms', function() {
    $('.advanced').toggle();
  })
  
});