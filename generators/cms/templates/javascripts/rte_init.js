function config_toolbars() {
  cms_basic_toolbars = [
    [ 'Copy','Cut','Paste','PasteText','PasteFromWord', '-', 'Bold','Italic','Underline','Strike','-','Subscript','Superscript', '-', 'NumberedList','BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'Undo','Redo', '-', 'NumberedList', 'BulletedList', 'Link','Unlink','Anchor' ]
  ]
  
  cms_full_toolbars = cms_basic_toolbars.concat([
    '/',
    ['Table', '-', 'Source']
  ])
}

$(document).ready(function() { 
  if(typeof $('textarea.richText').ckeditor == 'function') { 
    config_toolbars();
    $('textarea.richText').ckeditor( function() { /* callbacks */ }, {
      toolbar: 'CmsFull',
      toolbar_CmsBasic: cms_basic_toolbars,
      toolbar_CmsFull: cms_full_toolbars
    });
  }
});