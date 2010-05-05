function init_CodeMirror(){
    $('.codeTextArea').each(function(i, el){
        try{
          CodeMirror.fromTextArea(el, {
            parserfile: ["parsexml.js", "parsecss.js", "tokenizejavascript.js", "parsejavascript.js", "parsehtmlmixed.js"],
            stylesheet: ["/stylesheets/codemirror/xmlcolors.css", "/stylesheets/codemirror/jscolors.css", "/stylesheets/codemirror/csscolors.css"],
            path: "/javascripts/codemirror/",
            iframeClass: 'codeMirrorIframe'
          });
        }catch(e){ }
      });
}

$(document).ready(function() {
  init_CodeMirror();
});
