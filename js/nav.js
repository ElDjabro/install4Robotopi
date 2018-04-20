
  var xmlns = "http://www.w3.org/2000/svg",
  xlinkns = "http://www.w3.org/1999/xlink",
  select = function(s) {
    return document.querySelector(s);
  },
  selectAll = function(s) {
    return document.querySelectorAll(s);
  },
    size = 20
  TweenMax.set('svg', {
  visibility: 'visible'
  })

  select('#joinLine').setAttribute('stroke-width', size);
  var maskSource = select('#circleGroup').cloneNode(true);
  maskSource.id = '';
  maskSource.setAttribute('fill', '#fff');
  maskSource.setAttribute('stroke', '#777777');
  maskSource.setAttribute('stroke-width', 5);
  select('#radioMask').appendChild(maskSource);
  select('#mainGroup').setAttribute('mask', 'url(#radioMask)')

  document.body.onclick = function(e){
  var target = e.target;
  if(target.tagName == 'circle'){
            var id = target.id;
            var tl = new TimelineMax();
            tl.to('#joinLine', 0.3, {
              attr:{
                x2:target.getAttribute('cx')
              },
              strokeWidth:0,
              ease:Power2.easeIn
            }).to('#joinLine', 1, {
              attr:{
                x1:target.getAttribute('cx')
              },
              ease:Elastic.easeOut.config(1, 0.76)
            }, '+=0')
              .to('#joinLine', 2, {
              strokeWidth:size,
              ease:Elastic.easeOut.config(1, 0.8)
            }, '-=1')
            tl.timeScale(2)
        }
      }
