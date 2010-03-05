document.observe("dom:loaded", function() {
  // the element in which we will observe all clicks and capture
  // ones originating from pagination links
  var container = $(document.body)
  if (container) {
    var img = new Image
    // img.src = '/images/preloaderbt1.gif'
    img.src = '/images/spinner.gif'
    
    function createSpinner() {
      return new Element('img', { src: img.src, 'class': 'spinner' })
    }
    
    container.observe('click', function(e) {
      var el = e.element()
      if (el.match('.pagination a')) {
        $('preloader').show();
        // $$('body').insert(new Element('div', {:class}))
        // el.up('.pagination').up('div').insert({top: createSpinner()})
        new Ajax.Request(el.href, { method: 'get',
          onSuccess: function() {
            $('preloader').hide();
          }
        })
        e.stop()
      }
    })
  }
})