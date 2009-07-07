document.observe("dom:loaded", function() {
    try{
        Event.observe($('page_label'), 'keyup', function(e){
            $('page_slug').value = slugify( $('page_label').value );
        });
    } catch(e){ }
});

// slugify was found at http://dense13.com/blog/2009/05/03/converting-string-to-slug-javascript
function slugify(str) {
  str = str.replace(/^\s+|\s+$/g, ''); // trim
  
  // remove accents, swap ñ for n, etc
  var from = "ÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛàáäâèéëêìíïîòóöôùúüûÑñÇç·/_,:;";
  var to   = "aaaaeeeeiiiioooouuuuaaaaeeeeiiiioooouuuunncc------";
  for (var i=0, l=from.length ; i<l ; i++) {
    str = str.replace(new RegExp(from[i], "g"), to[i]);
  }

  str = str.replace(/[^a-zA-Z0-9 -]/g, '') // remove invalid chars
    .replace(/\s+/g, '-') // collapse whitespace and replace by -
    .toLowerCase();
  return str;
}

function check_parents_if_checked(obj, parents) {
  if (obj.checked == true) {  
    parents.each(function(id) {
      $('checkbox_cms_category_'+id).checked = true;      
    });
  }
}