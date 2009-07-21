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

function toggle_category_selections(obj, parents, children){
  if (obj.checked == true){
    parents.each(function(id){
      $('cms_category_id_' + id).checked = true
    })
  } else {
    children.each(function(id){
      $('cms_category_id_' + id).checked = false
    })
  }
}