function init_TinyMCE(){
    tinyMCE.init({
      mode : "specific_textareas",
      editor_selector : "mceEditor",
      theme : "advanced",
      theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect,code",
      theme_advanced_buttons2 : '',
      theme_advanced_buttons3 : '',
      theme_advanced_toolbar_location : "top",
      theme_advanced_toolbar_align : "left",
    });
}

try{
    init_TinyMCE();
}catch(e){}
