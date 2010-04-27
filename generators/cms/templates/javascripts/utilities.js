function slugify_field(field, value) {
  field.value = slugify(value)
}

// slugify was found at http://dense13.com/blog/2009/05/03/converting-string-to-slug-javascript
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

  // Expand/Collapse tree function
  $('.tree_toggle').bind('click', function() {
    $(this).siblings('ul').toggle();
    $(this).toggleClass('closed');
    element_id = $(this).parent().attr('id').split('_')[2];
    element_type = $(this).parent().attr('title');
    $.ajax({url: ['/cms-admin', element_type, element_id, 'toggle'].join('/')});
  })
  
  // Show/hide details
  $('.details_toggle').bind('click', function() {
    $(this).parent().siblings('table.details').toggle();
  })

  // Sortable trees
  $('.sortable').each(function(){
    $(this).sortable({  handle: 'div.dragger', 
                        update: function() {
                          $.post('/cms-admin/layouts/reorder', '_method=put&'+$(this).sortable('serialize'));
                        } 
    })
  })
});