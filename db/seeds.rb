js_text = <<-EOF
var speed = 5; //speed of particle movement
var noofparticles = 15000; //number of particles
var sizeofparticles = 40; //size of particle
var speedcam = 10; //speed of camera movement..set to ZERO for NO CAMERA MOVEMENT
var flagcam = 0;
var lastz = 5000;
lastz = lastz - lastz%speedcam;

var camera, scene, renderer, particles, geometry, material, i, h, color, size;
var mouseX = 0, mouseY = 0;
var flagy,flagx,flagz;
var ox1;
var oy1;
var oz1;
var exx = 0;
var eyy = 0;
var click1 = 0;

var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;

init();
animate();

function init() {
  ox1 = new Array();
  oy1 = new Array();
  flagx = new Array();
  flagy = new Array();
  flagz = new Array();
  oz1 = new Array();

  camera = new THREE.PerspectiveCamera( 55, window.innerWidth / window.innerHeight, 2, noofparticles );
  camera.position.z = 0;

  $('body').click(
  function(){if(click1 == 0)click1 = 1;else click1 = 0;}
  );

  $('*').mousemove(
  function abc(e)
  {
    exx = (e.pageX - windowHalfX);
    exx =  exx - exx%speed;
    eyy = (windowHalfY-e.pageY);
    eyy =  eyy - eyy%speed;
    });

    $('*').keydown(function(e)
    {
      if(event.which == 38){camera.position.z-=2*speedcam;}
        if(event.which == 40){camera.position.z+=2*speedcam;}
          if(event.which == 37){camera.position.y -=2*speed;}
            if(event.which == 39){camera.position.y +=2*speed;}
              });

              scene = new THREE.Scene();
              scene.fog = new THREE.FogExp2( 0xffffff, 0.0001 );
              geometry = new THREE.Geometry();
              sprite = THREE.ImageUtils.loadTexture( "https://lh3.ggpht.com/fqJP-rHMUAoCm5ua8EWKMEF4VAqdZl83LRfJn8TLzBY7fEYfUD5Nfu329RNyLXcsRso=w170" );
              for ( i = 0; i < noofparticles; i ++ )
                {
                  var vertex = new THREE.Vector3();

                  ox1[i] = parseInt(4000 * Math.random()) - 2000;
                  ox1[i] = ox1[i] - (ox1[i]%speed);
                  vertex.x = ox1[i];
                  flagx[i] = 0;

                  oy1[i] = parseInt(2000 * Math.random()) - 1000;
                  oy1[i] = oy1[i] - (oy1[i]%speed);
                  vertex.y = oy1[i];
                  flagy[i] = 0;

                  oz1[i] = parseInt(-noofparticles/2 * Math.random()) + noofparticles/4;
                  oz1[i] = oz1[i] - (oz1[i]%speed);
                  vertex.z = oz1[i];
                  flagz[i] = 0;
                  geometry.vertices.push( vertex );
                }

                material = new THREE.ParticleBasicMaterial( { size:sizeofparticles, sizeAttenuation: true, map: sprite, transparent: true } );
                material.color.setHSL( 1.0, 0.3, 0.7 );
                particles = new THREE.ParticleSystem( geometry, material );
                particles.sortParticles = true;
                scene.add( particles );

                renderer = new THREE.WebGLRenderer( { clearAlpha: 1 } );
                renderer.setSize( window.innerWidth, window.innerHeight );

                document.body.appendChild( renderer.domElement );
                document.addEventListener( 'mousemove', onDocumentMouseMove, false );
                document.addEventListener( 'touchstart', onDocumentTouchStart, false );
                document.addEventListener( 'touchmove', onDocumentTouchMove, false );
                window.addEventListener( 'resize', onWindowResize, false );
              }

              function onWindowResize() {
                windowHalfX = window.innerWidth / 2;
                windowHalfY = window.innerHeight / 2;
                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();
                renderer.setSize( window.innerWidth, window.innerHeight );
              }

              function onDocumentMouseMove( event ) {
                mouseX = event.clientX - windowHalfX;
                mouseY = event.clientY - windowHalfY;
              }

              function onDocumentTouchStart( event ) {

                if ( event.touches.length == 1 ) {
                  event.preventDefault();
                  mouseX = event.touches[ 0 ].pageX - windowHalfX;
                  mouseY = event.touches[ 0 ].pageY - windowHalfY;
                }
              }

              function onDocumentTouchMove( event ) {
                if ( event.touches.length == 1 ) {
                  event.preventDefault();
                  mouseX = event.touches[ 0 ].pageX - windowHalfX;
                  mouseY = event.touches[ 0 ].pageY - windowHalfY;
                }
              }

              function animate() {
                requestAnimationFrame( animate );
                render();
              }

              function render() {
                var time = Date.now() * 0.0005;

                if(exx != 0 && eyy !=0)
                  for(var j = 0;j < geometry.vertices.length;j++)
                    {
                      if (flagy[j] == 0 && click1 == 0)
                        {
                          if(geometry.vertices[j].y > eyy)geometry.vertices[j].y-=speed;
                          else if(geometry.vertices[j].y < eyy){geometry.vertices[j].y+=speed;}
                          else if(geometry.vertices[j].y == eyy)
                            flagy[j] = 1;
                          }
                          if (flagy[j] == 1 && click1 == 1)
                            {
                              if(geometry.vertices[j].y > oy1[j])
                                geometry.vertices[j].y -= speed;
                              else if(geometry.vertices[j].y < oy1[j]){geometry.vertices[j].y+=speed;}
                              else if(geometry.vertices[j].y == oy1[j])
                                flagy[j] = 0;
                              }
                            }
                            if(speedcam != 0)
                              {
                                if(flagcam == 0)camera.position.z += speedcam;
                                else if(flagcam == 1)camera.position.z -= speedcam;
                                }
                                if(camera.position.z == lastz || camera.position.z == -lastz)
                                  {
                                    if(flagcam == 0)flagcam = 1;else flagcam = 0;
                                    }
                                    // $('div').text(flagcam +" "+camera.position.z);
                                    camera.position.x += ( mouseX - camera.position.x ) * 0.05;
                                    camera.position.y += ( - mouseY - camera.position.y ) * 0.05;
                                    camera.lookAt( scene.position );

                                    h = ( 360 * ( 1.0 + time ) % 360 ) / 360;
                                    material.color.setHSL( h, 0.5, 0.5 );

                                    renderer.render( scene, camera );
                                  }
                                  EOF

Preview.create(title:"Feisty Pins",
 html:'<div></div><script src="//cdnjs.cloudflare.com/ajax/libs/three.js/r61/three.min.js"></script>',
 js:js_text,
 css:<<-EOF
  body {color:white;
   font:16px calibri;
   background: -webkit-linear-gradient(#000,#222,white);
   margin: 0;
   overflow: hidden;
  }
  div{position:absolute;}
 EOF
)

js_text = <<-EOF
/* polyfill requestAnimationFrame
* taken from:
*   https://gist.github.com/paulirish/1579671
* then minified with:
*   http://closure-compiler.appspot.com/
*/
(function(){for(var e=0,b=["ms","moz","webkit","o"],a=0;a<b.length&&!window.requestAnimationFrame;++a)window.requestAnimationFrame=window[b[a]+"RequestAnimationFrame"],window.cancelAnimationFrame=window[b[a]+"CancelAnimationFrame"]||window[b[a]+"CancelRequestAnimationFrame"];window.requestAnimationFrame||(console.log("fill"),window.requestAnimationFrame=function(a,b){var c=(new Date).getTime(),d=Math.max(0,16-(c-e)),f=window.setTimeout(function(){a(c+d)},d);e=c+d;return f});window.cancelAnimationFrame||(window.cancelAnimationFrame=function(a){clearTimeout(a)})})()


// start the actual code

// some basic variables for later use
var particles = {};
var particleIndex = 0;
var particleCount = 10;
var mouse = {};


/**
* @class Canvas
* @description
*   allow creating a canvas
*/
function Canvas(){
  var _this = this;
  _this.canvas = document.createElement('canvas');
  _this.context = _this.canvas.getContext('2d');
}

/**
* @function Canvas.init
* @description
*   sets the basic properties of a black fullscreen canvas
*/
Canvas.prototype.init = function(){
  var _this = this;
  var style = _this.canvas.style;
  style.background = '#000';
  style.position = 'absolute';
  style.cursor = 'none';
  style.top = 0;
  style.left = 0;
  document.body.appendChild(_this.canvas);
}

/**
* @function Canvas.scale
* @description
*   make the canvas fullscreen
*/
Canvas.prototype.scale = function(){
  var _this = this;
  _this.canvas.height = window.innerHeight;
  _this.canvas.width = window.innerWidth;
}

/**
* @class Particle
* @description
*   allow creating particles
*/
function Particle(c){
  var _this = this;
  _this.canvas = c;
  _this.x = mouse.x || _this.canvas.canvas.width / 2;
  _this.y = mouse.y || _this.canvas.canvas.height / 2;
  _this.velocityX = Math.random() * 6 - 3;
  _this.velocityY = Math.random() * 6 - 3;
  _this.size = ~~(Math.random()*4) + 1;
  _this.age = 0;
  _this.death = Math.random() * 50 + 10;
  _this.gravity = Math.random() + 0.1;
  particleIndex++;
  _this.id = particleIndex;
  particles[particleIndex] = _this;

  };

  /**
  * @function Particle.draw
  * @description
  *   draws the actual particles
  */
  Particle.prototype.draw = function(){
    var _this = this;
    _this.canvas.context.globalCompositeOperation = 'lighter';
    _this.x += _this.velocityX;
    _this.y += _this.velocityY;
    _this.velocityY += _this.gravity;
    _this.velocityX += _this.gravity;

    // let's do some random stuff to the direction
    if(Math.random() <= 0.5) {
      _this.velocityY = Math.random() * 10 - 5
      _this.velocityX = Math.random() * 10 - 5;
    }

    // everybody must die some time
    // particles randomly die after a while
    _this.age++;
    if (_this.age >= _this.death) {
      delete particles[_this.id];
    }

    // we also want to randomly change the color
    _this.canvas.context.fillStyle = 'hsla(' +
    ~~(Math.random() * 180 - 50) +
    ',100%,50%,0.3)';
    // a particle is actually a circle/arc
    _this.canvas.context.beginPath();
    _this.canvas.context.arc(_this.x,_this.y,_this.size,0,Math.PI*2,false);
    _this.canvas.context.fill();
    };







    // let's create a canvas
    var c = new Canvas;
    c.init();





    /**
    * @function run
    * @description
    *   will provide an interval like function with
    *   requestAnimationFrame to draw the particles
    */
    function run(){
      c.context.globalCompositeOperation = 'source-over';
      c.context.fillStyle = 'rgba(0,0,0,0.1)';
      c.context.fillRect(0,0,c.canvas.width,c.canvas.height);

      // let's create some particles
      for (var i = 0; i < particleCount; i++) {
        new Particle(c);
      }
      // and draw each one seperately
      for (var i in particles) {
        particles[i].draw();
      }
      requestAnimationFrame(run);
    }
    /**
    * @function scaleCanvas
    * @description
    *   allow to scale the canvas to fill the window
    */
    function scaleCanvas(){
      c.scale();
    }
    /**
    * @function followMouse
    * @description
    *   make the particles follow the mouse
    */
    function followMouse(e){
      mouse.x = e.pageX;
      mouse.y = e.pageY;
    }
    /**
    * @function forgetMouse
    * @description
    *   forget the mouse data
    */
    function forgetMouse(e){
      mouse.x = false;
      mouse.y = false;
    }


    // init stuff
    scaleCanvas();
    run();
    // the canvas is always fullscreen
    window.addEventListener('resize', scaleCanvas);
    c.canvas.addEventListener('mousemove', followMouse);
    c.canvas.addEventListener('mouseleave', forgetMouse);
  EOF
Preview.create(title:"Follow the Mouse", html:"<div></div>", js: js_text)
