function config_toolbars() {
  cms_basic_toolbars = [
    [ 'Copy','Cut','Paste','PasteText','PasteFromWord', '-', 'Bold','Italic','Underline','Strike','-', 'NumberedList','BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'Undo','Redo', '-', 'Link','Unlink','Anchor', '-', 'Table' ]
  ]
  
  cms_full_toolbars = cms_basic_toolbars.concat([
    '/',
    ['Subscript','Superscript', '-', 'Source']
  ])
}

function init_RTE() { 
  if(typeof $('textarea.richText').ckeditor == 'function') { 
    config_toolbars();
    $('textarea.richText').ckeditor( function() { /* callbacks */ }, {
      toolbar: 'CmsFull',
      toolbar_CmsBasic: cms_basic_toolbars,
      toolbar_CmsFull: cms_full_toolbars,
      on: { instanceReady : function( ev ) {
                              this.dataProcessor.writer.indentationChars = '  ';
                              this.dataProcessor.writer.setRules( '#',
                                {
                                   breakBeforeClose: true,
                                });
                            }
          }
    });
  }
}

$(document).ready(function() { 
  init_RTE();
});