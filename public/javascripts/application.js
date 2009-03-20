function linkToggleElement(link, element){
  if( element.style.display == 'none' ){
    link.innerHTML = '&ndash;'
    element.show()
  }else{
    link.innerHTML = '+'
    element.hide()
  }
}