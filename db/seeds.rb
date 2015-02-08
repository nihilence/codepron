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

js_text = <<-EOF
var draw = fullscreenCanvas();
var canvas = draw.canvas;
var ctx = draw.ctx;

var rad = Math.PI / 180;

var noise = generatePerlinNoise(512, 512).map(function (i) {
  return i * 4;
  });

  function sine (offset, multiplier, length) {
    var x;
    var y;
    var lastx = 0;
    var lasty = 0;
    var q;

    var i;

    var width = 10;

    for (i = 0; i < length; i++) {
      x = i;
      q = i / 50;
      y = Math.cos((-(i * multiplier) + offset) * rad) * q * q * q * 1.1;

      a = 1 - (i / (length * .9));

      ctx.strokeStyle = blackOnWhite ? "rgba(0, 0, 0," + a +")" : "rgba(255, 255, 255," + a +")";
      ctx.lineWidth = width * a;
      ctx.beginPath();
      ctx.moveTo(lastx, lasty);
      ctx.lineTo(x, y);
      ctx.stroke();
      ctx.closePath();

      lastx = x;
      lasty = y;
    }
  }

  function clear () {
    ctx.fillStyle = blackOnWhite ? "rgba(255, 255, 255, .2)" : "rgba(0, 0, 0, .3)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
  }

  var offset = 0;
  var amount = 15;
  var blackOnWhite = false;

  var sizes = new Array(amount);
  var sizes = sizes.fill("a").map(function () {
    return Math.random() * 200 + 100;
    });

    function render () {
      clear();
      offset += 1;
      var i = 0;
      ctx.save();
      ctx.translate(canvas.width / 2, canvas.height / 2);
      ctx.rotate(offset / 10 * rad);
      for (var i = 0; i < amount; i++) {
        sine(offset * noise[i], 1.2, sizes[i], offset);
        ctx.rotate(360 / amount * rad);
      }
      ctx.restore();
    }

    window.addEventListener("click", function () {
      blackOnWhite = !blackOnWhite;
      });

      setInterval(render, 1/60);
  EOF

html_text = <<-EOF
  <p></p><script src="http://files.martijnbrekelmans.com/cdn/drawingCollection.js"></script><script src="http://files.martijnbrekelmans.com/cdn/noise.js"></script>
EOF

Preview.create(title:"Sunspire", html:html_text, js: js_text)


html_text = <<-EOF
<script src="//cdnjs.cloudflare.com/ajax/libs/sketch.js/1.0.0/sketch.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/dat-gui/0.5/dat.gui.min.js"></script>
<script id="vs" type="x-shader/x-vertex">
#ifdef GL_ES
precision mediump float;
#endif

attribute vec3 position;
attribute vec4 color;
attribute vec2 textureCoord;
varying   vec4 vColor;
varying   vec2 vTextureCoord;

void main() {
  vColor        = color;
  vTextureCoord = textureCoord;
  gl_Position = vec4 (position, 1);
}
</script>
<script id="fs" type="x-shader/x-fragment">
#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D texture;
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

varying vec4      vColor;
varying vec2      vTextureCoord;

float atoms(vec3 pos, float radius)
{
  return radius / pow(length(pos), 256.0);
}

void main( void ) {
  vec2 position = ( gl_FragCoord.xy / resolution.x ) - vec2(0.5, 0.5 * (resolution.y / resolution.x));

  //vec4 smpColor0 = texture2D(texture, vTextureCoord);
  //vec3 color = vec3(smpColor0.r, smpColor0.g, smpColor0.b);
  vec3 color = vec3(0,0,0);

  vec3 pos = vec3(0.0, 0.0, 0.0);
  for( int i=0; i<32; i++){
    float k = float(i);
    pos.x = position.x + sin(k*k + 0.1*time) * 0.5;
    pos.y = position.y + sin(k*k*k + 0.25*time) * 0.5;
    pos.z = sin(k*k*k*k + 0.05*time) + 2.000;
    pos.z = 1.0;
    color.r += atoms(pos, 2.0)*1.1;
    color.g += atoms(pos, 2.0)*1.0399;
    color.b += atoms(pos, 2.0)*1.98;
  }

  vec3 c = mod(color, 2.0);
  if (c.r > 1.0) c.r = 2.0 - c.r;
    if (c.g > 1.0) c.g = 2.0 - c.g;
      if (c.b > 1.0) c.b = 2.0 - c.b;

        gl_FragColor = vec4(c, 1.0) * vColor;

        //vec4 smpColor0 = texture2D(texture, vTextureCoord) ;
        //gl_FragColor   = smpColor0 * vColor;
      }
      </script>
      <div id="container">
      </div>
  EOF

  js_text = <<-EOF
  (function() {
    var GLSL, error, gl, gui, nogl;

    GLSL = {
      vert: "\n#ifdef GL_ES\nprecision mediump float;\n#endif\n\n// Uniforms\nuniform vec2 u_resolution;\n\n// Attributes\nattribute vec2 a_position;\n\nvoid main() {\n    gl_Position = vec4 (a_position, 0, 1);\n}\n",
      frag: "\n#ifdef GL_ES\nprecision mediump float;\n#endif\n\nuniform bool u_scanlines;\nuniform vec2 u_resolution;\n\nuniform float u_brightness;\nuniform float u_blobiness;\nuniform float u_particles;\nuniform float u_millis;\nuniform float u_energy;\n\n// http://goo.gl/LrCde\nfloat noise( vec2 co ){\n    return fract( sin( dot( co.xy, vec2( 12.9898, 78.233 ) ) ) * 43758.5453 );\n}\n\nvoid main( void ) {\n\n    vec2 position = ( gl_FragCoord.xy / u_resolution.x );\n    float t = u_millis * 0.001 * u_energy;\n    \n    float a = 0.0;\n    float b = 0.0;\n    float c = 0.0;\n\n    vec2 pos, center = vec2( 0.5, 0.5 * (u_resolution.y / u_resolution.x) );\n    \n    float na, nb, nc, nd, d;\n    float limit = u_particles / 40.0;\n    float step = 1.0 / u_particles;\n    float n = 0.0;\n    \n    for ( float i = 0.0; i <= 1.0; i += 0.025 ) {\n\n        if ( i <= limit ) {\n\n            vec2 np = vec2(n, 1-1);\n            \n            na = noise( np * 1.1 );\n            nb = noise( np * 2.8 );\n            nc = noise( np * 0.7 );\n            nd = noise( np * 3.2 );\n\n            pos = center;\n            pos.x += sin(t*na) * cos(t*nb) * tan(t*na*0.15) * 0.3;\n            pos.y += tan(t*nc) * sin(t*nd) * 0.1;\n            \n            d = pow( 1.6*na / length( pos - position ), u_blobiness );\n            \n            if ( i < limit * 0.3333 ) a += d;\n            else if ( i < limit * 0.6666 ) b += d;\n            else c += d;\n\n            n += step;\n        }\n    }\n    \n    vec3 col = vec3(a*c,b*c,a*b) * 0.0001 * u_brightness;\n    \n    if ( u_scanlines ) {\n        col -= mod( gl_FragCoord.y, 2.0 ) < 1.0 ? 0.5 : 0.0;\n    }\n    \n    gl_FragColor = vec4( col, 1.0 );\n\n}\n"
      };

      try {
        gl = Sketch.create({
          container: document.getElementById('container'),
          type: Sketch.WEB_GL,
          brightness: 0.8,
          blobiness: 1.5,
          particles: 40,
          energy: 1.01,
          scanlines: false
          });
          } catch (_error) {
            error = _error;
            nogl = document.getElementById('nogl');
            nogl.style.display = 'block';
          }

          if (gl) {
            gl.createShaderProgram = function(src, type){

              var shader = gl.createShader( type );
              var line, lineNum, lineError, index = 0, indexEnd;


              gl.shaderSource( shader, src );
              gl.compileShader( shader );


              if ( !gl.getShaderParameter( shader, gl.COMPILE_STATUS ) ) {

                var error = gl.getShaderInfoLog( shader );

                // Remove trailing linefeed, for FireFox's benefit.
                while ((error.length > 1) && (error.charCodeAt(error.length - 1) < 32)) {
                  error = error.substring(0, error.length - 1);
                }

                return null;

              }

              return shader;
              };
              gl.loadAndCreateTexture = function(source, texture){
                var img = new Image();
                img.crossOrigin = "Anonymous";
                img.onload = function(){
                  var tex = gl.createTexture();
                  gl.bindTexture(gl.TEXTURE_2D, tex);
                  gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, img);
                  gl.generateMipmap(gl.TEXTURE_2D);
                  gl.bindTexture(gl.TEXTURE_2D, null);
                  texture(tex);
                  };
                  img.src = source;
                  };
                  gl.setup = function() {
                    var frag, vert;
                    this.activeTexture(this.TEXTURE0);
                    this.texture = null;
                    var self = this;
                    this.loadAndCreateTexture(panda_img_data, function(res){self.texture = res;});
                    this.clearColor(0.0, 0.0, 0.0, 1.0);

                    vert = this.createShaderProgram(document.getElementById('vs').textContent, this.VERTEX_SHADER);
                    frag = this.createShaderProgram(document.getElementById('fs').textContent, this.FRAGMENT_SHADER);

                    this.shaderProgram = this.createProgram();
                    this.attachShader(this.shaderProgram, vert);
                    this.attachShader(this.shaderProgram, frag);
                    this.linkProgram(this.shaderProgram);
                    if (!this.getProgramParameter(this.shaderProgram, this.LINK_STATUS)) {
                      throw this.getProgramInfoLog(this.shaderProgram);
                    }
                    this.useProgram(this.shaderProgram);
                    this.shaderProgram.attributes = {
                      position: this.getAttribLocation(this.shaderProgram, 'position'),
                      color: this.getAttribLocation(this.shaderProgram, 'color'),
                      textureCoord: this.getAttribLocation(this.shaderProgram, 'textureCoord')
                      };
                      this.shaderProgram.uniforms = {
                        resolution: this.getUniformLocation(this.shaderProgram, 'resolution'),
                        millis: this.getUniformLocation(this.shaderProgram, 'time'),
                        texture: this.getUniformLocation(this.shaderProgram, 'texture')
                        };
                        var position = [
                          -1.0,  1.0,  0.0,
                          1.0,  1.0,  0.0,
                          -1.0, -1.0,  0.0,
                          1.0, -1.0,  0.0
                          ];
                          var color = [
                            1.0, 1.0, 1.0, 1.0,
                            1.0, 1.0, 1.0, 1.0,
                            1.0, 1.0, 1.0, 1.0,
                            1.0, 1.0, 1.0, 1.0
                            ];
                            var textureCoord = [
                              0.0, 0.0,
                              1.0, 0.0,
                              0.0, 1.0,
                              1.0, 1.0
                              ];
                              var index = [
                                0, 1, 2,
                                3, 2, 1
                                ];
                                var vPosition     = this.create_vbo(position);
                                var vColor        = this.create_vbo(color);
                                var vTextureCoord = this.create_vbo(textureCoord);
                                var VBOList       = [vPosition, vColor, vTextureCoord];
                                var iIndex        = this.create_ibo(index);
                                var attLocation = [this.shaderProgram.attributes.position, this.shaderProgram.attributes.color, this.shaderProgram.attributes.textureCoord];
                                var attStride = [3, 4, 2];
                                this.set_attribute(VBOList, attLocation, attStride);
                                this.bindBuffer(this.ELEMENT_ARRAY_BUFFER, iIndex);
                                /*
                                this.geometry = this.createBuffer();
                                this.geometry.vertexCount = 6;
                                this.bindBuffer(this.ARRAY_BUFFER, this.geometry);
                                this.bufferData(this.ARRAY_BUFFER, new Float32Array([-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0]), this.STATIC_DRAW);
                                this.enableVertexAttribArray(this.shaderProgram.attributes.position);
                                this.vertexAttribPointer(this.shaderProgram.attributes.position, 2, this.FLOAT, false, 0, 0);
                                */
                                return this.resize();
                                };
                                gl.updateUniforms = function() {
                                  if (!this.shaderProgram) {
                                    return;
                                  }
                                  this.uniform2f(this.shaderProgram.uniforms.resolution, this.width, this.height);
                                  return;
                                  this.uniform1f(this.shaderProgram.uniforms.brightness, this.brightness);
                                  this.uniform1f(this.shaderProgram.uniforms.blobiness, this.blobiness);
                                  this.uniform1f(this.shaderProgram.uniforms.particles, this.particles);
                                  this.uniform1i(this.shaderProgram.uniforms.scanlines, this.scanlines);
                                  return this.uniform1f(this.shaderProgram.uniforms.energy, this.energy);
                                  };
                                  gl.draw = function() {
                                    this.uniform1f(this.shaderProgram.uniforms.millis, this.millis/300.0 + 5000);
                                    this.clear(this.COLOR_BUFFER_BIT | this.DEPTH_BUFFER_BIT);
                                    this.activeTexture(this.TEXTURE0);
                                    this.bindTexture(this.TEXTURE_2D, this.texture);
                                    this.uniform1i(this.shaderProgram.uniforms.texture, 0);
                                    //this.bindBuffer(this.ARRAY_BUFFER, this.geometry);
                                    //this.drawArrays(this.TRIANGLES, 0, 4);
                                    this.drawElements(this.TRIANGLES, 6, this.UNSIGNED_SHORT, 0);
                                    this.flush();
                                    };
                                    gl.resize = function() {
                                      this.viewport(0, 0, this.width, this.height);
                                      return this.updateUniforms();
                                      };
                                      gl.create_vbo = function(data){
                                        var vbo = this.createBuffer();
                                        this.bindBuffer(this.ARRAY_BUFFER, vbo);
                                        this.bufferData(this.ARRAY_BUFFER, new Float32Array(data), this.STATIC_DRAW);
                                        this.bindBuffer(this.ARRAY_BUFFER, null);
                                        return vbo;
                                        };
                                        gl.set_attribute = function(vbo, attL, attS){
                                          for(var i in vbo){
                                            this.bindBuffer(this.ARRAY_BUFFER, vbo[i]);
                                            this.enableVertexAttribArray(attL[i]);
                                            this.vertexAttribPointer(attL[i], attS[i], this.FLOAT, false, 0, 0);
                                          }
                                          };

                                          gl.create_ibo = function(data){
                                            var ibo = this.createBuffer();
                                            this.bindBuffer(this.ELEMENT_ARRAY_BUFFER, ibo);
                                            this.bufferData(this.ELEMENT_ARRAY_BUFFER, new Int16Array(data), this.STATIC_DRAW);
                                            this.bindBuffer(this.ELEMENT_ARRAY_BUFFER, null);
                                            return ibo;
                                            };
                                          }

                                          }).call(this);
                                          var panda_img_data = 'data:image/png;base64,'+
                                          'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAD//0lEQVR42ux9B7heZZXu2nv//39a'+
                                          'cnISehAIIuCISByxF4INEJBgm6rCzDijj46gM844NojdcTRRKSowQbCgIL23hK6UNIqAYEKHkHZy'+
                                          '6l/3/d611vvtfbxz5965JJwA2XCec3LOX/a/9/et8q53vSuRrcfWo3QcevDb5rQ7nYE8z2d3Oh0J'+
                                          '3yUP3zudfHH4acPi629ZNtnnuPXYdEcy2Sew9ZjcY+7hBw2EzT230+4cEVbDXEkSGRoalt7eXhkd'+
                                          'HZHu7h4ZGR6Waq0m4+PjUq1WpN3uLBbJLwhPP/+mW25fNdmfYevx/39sNQAv0OM9RxwSNn7n2LD5'+
                                          'j+nq6hoYGhqSLMuk3mjqd3j+4bDxpw8MyNp16/Q5aZJKiAIkPF4QHbRarWAM2ovDIvrJb25bevpk'+
                                          'f6atx//82GoAXoBH2PxzghdfmIvMmtLXGzZyR5548knp7emWtes3yMyddpSnnlottbDRE/yXprJ2'+
                                          '7RpJ00x6urv1NVrttkyd0qeGYHBwo9Rq1VXh1/Nuu2P56ZP9+bYe/+/HVgPwAjuOfPfBR4XbvhDh'+
                                          'fHfYzPVGIxiAtjSbTWn4z9VqVdatXy99wThUskrw+SLrg2Ho6e4KqcEU2TC4QbJKJttus41sCI/r'+
                                          'hGhhWv9UGRkZDY/MlyVJ8qnbl6xYPNmfdevxfz+2GoAX0BE8/8Lgz4+C916zdl3Y4H2yceNG6enp'+
                                          'Cxu/iXBeQ/9O3gm/H5Lurm5pd9pqFNI0USMxrX+aGg0snN7enhA5PCXbbbetGg08H7+v18fxdvOW'+
                                          'LLvr+Mn+zFuP//7YagBeIMeRRxx8bJak88frDRkeGQkbXQDmydj4WDAAvbp5kdPjqzuE/uuCx586'+
                                          'ZYo+tt1uabSwfv2gbLPNjBgtBE+vz5sxY4YMDw8pcJiFiCFLwxuGv9XHxxENHBgMwYbJ/vxbj//6'+
                                          '2GoAXgBH8Pxzg2c/rx3y9UajKevWrZeu7h7pqlVDOD+oxgCbd334PVYEU4FKpaK5fi1499HRMQUH'+
                                          '0zQNHr4ujWAEenvCa3TV1DgAMET0gOdMmzYtGIlGMCSoHNRXJWly5NJld20tH26Bx1YD8Dw/3jP3'+
                                          'kFmddmdps9kaaAWPD6/+8COPSK3WJVOm9Mnjjz+hm7mvb4qgEpAq4LdOpk6dqoYAX/39/brpm4gO'+
                                          'urs0PQA3YPr06ZIGdw8gEOAgyodIJfrCezTC47fbdhs1IHne2ZAm6YFLl281AlvasdUAPM+PuYcf'+
                                          'tCjk53NWP71WPfPY2Lh66yx4amzq4eERDeORw2Oz44AB6AkRQS1ECIgEEOrDuyP0x/eR8Jxa8O44'+
                                          'EBXgC1EC/o7XAV7QE6IDPBYGJfwTj9kQft5qBLawY6sBeB4fQPzD5l0IMs+qhx6WbbfdVr00wn5E'+
                                          'AOvWrdOaPsL7TgdGoKYYADYy0gVsbBgFgIGNENJXKlUlA+F3SBmQ9+Mx+HlkZEQNxZS+PjUCU6dO'+
                                          '0UgBUQbIQwkYBHm+IUnS3YMR2IoJbCHHVgPwPD6C918Z8vNZG8OmR61+SgjNUct/es2aEAmM6cZH'+
                                          'qA+joHl/uxW8dSYhZzcKcC4yNjoqU8JjYBgQ6jNSqNVqWkGAh4e3NwzA/g6jMm1avzIIATAibegK'+
                                          'j+/kbQkPWhbO4cAly+7cagS2gGOrAXieHmHzHxW880JswJWrVklv+J5mFVm3fp2G9evW2f7DBsZm'+
                                          'Hx0bjR6ekQDCeuADAPbMIORqBPBvpgs42DOQOR7AKACP6Qqbvxm+z5g+3UuFLay6BcuW3/2pyb5G'+
                                          'W48tzAC87KV7zu500ITSnhW+7xYW0yzUpMPPWFjLwiIbtO+y+MmnVm/1IP/NccRhB62sNxqzsPEe'+
                                          'fezxEJ6neh0HNw4Grz6mGAA2O6IAhO4A6/p6+2Qs/A6eHEsDxgF/w6bGzx1tCrLUAGkCogAcAA9h'+
                                          'FBAJkGDUaNT1udttt50aABgHRBsdMwD424FLl921eLKv0wv9mHQDsN++L5sTFtWHw9ec7p6eWfAk'+
                                          'OLDQsJiw2JSggiwy/A6166GhjVjMy8JjfhIeffr69Ru2GoPSAe8fNuzCNWvXKzrfDtcUJb7xel3/'+
                                          '3my2lAS0YcOgXmcQe5AaYDHAEOC60+vzOzc/NjU8OQ/vB4hAYUNfC0SAXO8dMABgBHhtvCfuIfoJ'+
                                          '0iRZtXT5XbtP9rV6oR+TZgD+dPa+RwVPf1wIUWdhAaVhsYyGfLN/ar8uKHh+eCecYuJniRp2pZIp'+
                                          'OQV/A0odvM+GvJN/L6y9BUPDw1sNgcD7v3NRuDZzNgwOow4vfVN65enVa2R92PDw0tisQP/xvamg'+
                                          'X0s3K0P5uhsKen7k9NzYShSCUQn3CM/Bv2EkOmqc2/o4/IzHtEKU0N3TLdXwd/AF8DqIBLq6uoMh'+
                                          'QCSQzFuy9M7jJ/t6vZCPZ90AvHr//eaGDTu/p7d3ljaaaIdZCDnzsChHhjWsRI6KcLXesIWIhYrN'+
                                          'D6QaTLN68FBYZFhQQLRxBOOxIfzu6LGx8fMn+6JO5nHkuw8OUZSsBIXX6vId3YSjI6NK/8UGxO/g'+
                                          '5bHxge7jHmAT82hoyG6bGwYBm5nenykAjASuP/6O3+PfuHfKFwgbH4YG+T47C2G4+0MKAJZh4qXB'+
                                          'YFA2hL/vfvuS5VsN9yQdz5oBeP1rX4X204Xhx7ngngMZBupcH6/raWDB1usN/Rn01AryTPdO+Lnl'+
                                          'PHMspo0h50Q4CZi65eEnUGhvRlkQXucFCzCF8H9+2FTHrl1rTTownNiMoPbiGmFzo+UXPH7r4qtp'+
                                          'WsVwv1kC/WAAtI7vX9zsmjaEjW41f/sbn0dKMfGBsbHR8F7Wa7DD9tvp3+31O+G8unFPj75j6Z2n'+
                                          'T/Z1e6Eez4oBeMPr958dcr9FU/qmDOSWAWpY327ZpkfWD29hnh/89LohymFhIm/VhYVc03vQsRCr'+
                                          'laoCVvAsPJAWwLOF11ocHnJkWGwvOM+C0l/YfLMee/xJZeo9+dRTWtrDxkeHHwwCNiGIPsbnTxWw'+
                                          'w7WHp0d5kCQeGgEcuAdlIBAHjAH7AYgLlB/PSgHCfxgMAJLNYAjwHfe7VlVDs2zJsrteOdnX7YV6'+
                                          'bHYD8KY3vPqosI7mhwUyMNXrybrpwSxrWc7IvNMaVKw1lfkmjAOAI0QDzEMRVuLUsdl1wYUnoncd'+
                                          'ixcLD1hC+D0YZweGxfqCMQLvOeKQ2WFDLsX1RTQ0bWBAHnr4Ed3c8PiPPfa4GlQAfgDmWh5h8boq'+
                                          '99+9Pjc2Dm503Cd6cAP6JP6OoT6rAIWRkJhOgAvANmK8XkXTEdzrbPrWNGByjs1qAN7yxtceFfzI'+
                                          'Qmz8dsjpM4SKLUOZG/WGK9CYAUApSevPCCHdADRbLW9FTXVzE1ziosPvsdlhPJiX4r0IYoXnAA84'+
                                          'crIv8rN1hPz/2LA55z+9xmr96Odfs2at1vIR5lvvf0sBQJCCQAvmdaR350anAcZ1TRyFrXs0hoMp'+
                                          'AR8XDXZuikE05EgFGl4G7Onu0d4B9AhYKtFWLCAswyPvWLriBY3dTNax2QzAAW9+3ezgvpdO7Z+q'+
                                          'HkcXhIb89dhOikWDkNQMwHBciFiswASwIJtcvL74WCZkLsqQE9/Zk06gCjlvOBaErxcEJhAMwKJa'+
                                          'tTpn/eCQ0nxT7d7L1Bg8+eST2guAqgCAU5J91DOHDYuDqD8PGgcaACL+ZeTf7mEj/rtsMGCcCQzi'+
                                          'gLwYQn+0D5u+QENViMItnbdk2dZqwGQcm8UAHPiWN8zu5J1F4eYPTJ3Sr2g+Fh7iQXh/HPi31fdF'+
                                          '83uErawnj2n934AiVANoMOD9saiw6LCwsMHxHC5gfEckgb8l/l6ehyIKeN57mCPffcj6Wq06ABv5'+
                                          '4B9W6Wfv6e3T6wtdP/xeuRWenxs5qDNhM+Mog3307Nz4+H3ZKJQfz0iAr4n+AOs1GFVcAVhAJ9wv'+
                                          'RB+ITvB3KAmF55+/dPldL5hIbUs6NrkBeNuBbwLaHzZ/12w0gWAjI88cRQgfbn7dFx68Qkvrxk0n'+
                                          '+LSjQUDJqubCk/RCzDOx6bHYsLCwgGAcNJ8MCw55raUS1eiJkDqExY78EqST53We+d6578qRZjWa'+
                                          'bRncOKQyXkbzNbYfdAAqBOvCPUEVBk1B3Ow4iOjjGjIlIBbAv5eNQvn4YwNQV7yBEUIW79OM6QP6'+
                                          'eNx3EIWCs1i8bPndB0729XshHpveAMx543nBw8wFB10XY1gU2JTqkcfG1QshJ1W0f8yiARgI1AbM'+
                                          'w6RxU5cZaGVUuVOqBtDzdLtYJWvY2PgwCDjQtCIvgFTgPUfAACQyOo40qy1PrV6tGxk5P4ylEqm0'+
                                          'bbelNx6EKlw3bmSmT9yo/JnXmGU+gnr/lTEo/0xwlwbcGoe6lZ0IgwAjDiAQBmD5inu2GoBJODap'+
                                          'AXjHW98yN6yV86ZMmaqgT6NpraWUoLJ+cgtDIU5RZzhaN+EJ60IrNnikATvYpM0lTj4ZDHksWWpE'+
                                          'nrHp8TfLdcetXBgWvC1+NR4oNz2r/eg3XH/tnJz/yPPZ4Wd3f7nY73P/3/+V5+WnL7bHxccse/vb'+
                                          '3/V/jGLec8QhuQKjY5ZOrXroIW3MAb6CjsC+4G1R+xenVbdK5TurrMiEKgDD/DLSz3yfqD9LhWUO'+
                                          'AJWD8IVrX1EmYJfm/xAXgVgI0gBUJsLdDueSL15+51YDMBnHJjMAB739gIFOni/t6+ubZWCcAXea'+
                                          'h6vHSRzVN6PQ9BAUOT5y1JGQJ8L74+fEEWYuLnok5qhjHtJSpIJeXz9Q+D0wAJwDgUE8xqOAxeFr'+
                                          'ky+0G25YPCdsk9lim/sAfA+LG//WhQ8gDtsX3IVK1cPmaABKm56/w4brtA030Z1vv0curY9FWD86'+
                                          'uixHSpPLqvDXh8JnXvWDBQsWpvDWaPoZHFKpbxCmkAoACMS5QO67J2w80n8Z/ls3XxavK68dz69c'+
                                          'ISjX/csGoNwvQIPNMi8xABgkMxKpawjqay5ecefvthqASTg2pQE4Pqtkx4HLj8UG7wIDsFHD/1TX'+
                                          '8aiH/FCNhYHo+GLCgrAyX9FMQs9e8a41eAzmpngs/l4q98VFRg9FD8acFO+DDSRmABb//37OG2+8'+
                                          'Dht7TvhA+2VpNqeru2sWzgXMRm5wpTfnBVkG0togwGhE0+qEqMcMGTyi7edc2Y709Hgsfq+0XTAh'+
                                          'w2tqR10Im1shtK9ULTLCZh8aHo7l0FN/9GN5+umnpRryetT8cR/GlPLbDNeqqdcRZCB4Ydx6blZe'+
                                          'QzNWaYy6yjk+Q3gcZcCwbKD5OF533B86ARjlbbfdRnEg/L1/Wr81KoXPGo55K+763fGbdaVvPf7L'+
                                          'Y5MYgEMOeutAWPArQ+g9ADTf8nXz8liYCvBpd19dQUCE/Nj8wAhgKMAIJFDFTW1ccgOfiAHAi5us'+
                                          'lS3WDRs2qIcjIQgehc/hIi4vamARYtWA/2fE+b577561Zs2aOSFVOSK83pypU6YMoMddN70DlTjU'+
                                          'A5Z65rXGnZrhQ94No6clsXH0yBtNFtGO9dtbuQ5GAxtfN5X2zNpcvtRDb/L4IeaJCEEPPN4591df'+
                                          'eZVccfnlml6tVd6/XTO8B/CW0dFxfR7TrHIEgGvIRiHm7eXSXrnUxwP/JnOQBx9HbAB/xxf4GUD+'+
                                          'wfHA9YPBmz59QP/9rkPftfiQdx0yL5zXsgMPfMfzGqjd0o5NYwDeeeCxYRHPh9KshZapfh9xam7e'+
                                          'MTAIoT1kohLfkKzh4zEa/jt5BIsQi455Jb0JjAlyfTyGOT816fB3gn7l+jMFLbEx8Xg3EKgIrPo/'+
                                          'fZ4bb1w8K5zD3HB5Phw2+expA9P0tcu5b+roeN3TD0QmDOUNTAs5c9jUHcchtD/e0yCEwjB6uPoa'+
                                          'mocNjWc2nBYNiixKpvT6+D2iAGwW/FsZk8jVMwNM8ST8fmPI77/z7W8rB2BDSAFqXd0yDDUgVe6x'+
                                          'LsqmA7D4DgNRBllZ6qOH52dl6I+D0RSNK64tAdjy35l60bgMhGuID4wOTk3X8o4pCofXOOHEExSf'+
                                          'gPEIj8V9WRY+33VIDd729kO2aghuxmNTGYClIQSe3ckRulfV2+DGI+SHpBSZaLjxBs7ZpsffsQhg'+
                                          'FOBFiOwzb8Qiqqr3rEd6MBcfvmNTsmzFf6uh8RAUGx4RAr0UHudRAKoBC8qf4dprrxhIkmxueL9j'+
                                          'gvGYDf17eK20hEeUUwpuDnbBlXPnjn7WVDexhdnW99DxrjiP9NVIwChY2pCo4aKRaXkagMdr510I'+
                                          '65EasGcfByKo8bqlScQJVq1cKfO/O98rLFb6GxoeUe4/xDyBtTRDdJb4BueG5yZmSM/24DIxCAev'+
                                          'vUiRCjD8p1QYDTNLgbjuIP/g76oPGD4EdAZrtYrsuusuctp/nhqNEOnEiO5GRkyw9A8PPiDr1q5b'+
                                          'fP999+IaXSdmvJf97KzzthqHZ3g8YwNw2MFvm5WkycpupXnaogEPnVx/hKAW1ieR3osFOKKAligj'+
                                          'jOVA1pyJOLP8VMYFuGBJDEp0mu2QpgbMP/mFhcQN3Ofg0/qQA4tVArQB5eKLL5gd3uuYnp7uudND'+
                                          'TBqOaHj0dcTOARUKAo04aIxoDCIS3mprLs86unpBfB7HJbQ60iAeYFEArgF2LzQQRCfz5Jr7w6uj'+
                                          'l56CnDAKCtghDCc/3wU2cMAgIMRfteohmf8f35W1YfPj2vJa63XztGxMjW9X9NQ42MHHo+zNy0e5'+
                                          'XMhKDdMBdhQyMsPvEC11a3phBgbzBGAIUAX4m789Wv7iL/5cryexAnUC3m2Ym5ioradwz5966klZ'+
                                          'vmy5/P7++2V9iHSCMVwsZhCWixmFxZO9qZ5LxzM2AIce/LZjw42arx5RxG9k3QGouowDoAu/B4EH'+
                                          'Nxcdey1fQOZBG6WQNIuIPr0qPIHOsHO+v3ayuQglNyEOdL4RC8DfGfbzOQAR8be1a9fq4y+44Nwj'+
                                          'gwc+ZsqUqXMGgvGYHjwUFqWebGKDMgyIM6NW8U2epEVpDL/XTZN77utUZHhtRjP4GzYlQ+zis5oh'+
                                          'QEisfRExMsgdGOzoxtFIAa9ZreimxeM10kCq5GVTPE58c+Ue0sPQnv2rc+SiCy+y+6BgoKVdqgyk'+
                                          'BiePYT/TGH42goMEXmlcedAA02Nz45eNIu8PAFLcj4FpA+GxYzpdCNEPwv+f/eJn2hykht2lyKrW'+
                                          'JWhpTppGI6ClXKoUhf9WP/WULFuyRB584EE1NHz/8PkWhxdCpLB4q0H4749NYQAWhht8FPJJsM/M'+
                                          'c1pYDg+kff/B6wxaGU4XJowAvTk7A3Gwz7ycUxNAQl6LTcmaP8JDbD4Kg7DujIjDGl2seYhpAQFC'+
                                          'GA6c27e++XU5YM5btFfdwtUsLto+/x0WpIW35m0tDclU4pobouLnyU1rX7k/3vJ9bnqw7jTsR2rQ'+
                                          'tkoJtffx/jQIBAIRGRCQYyTAfF9zd+2vsHPSJyVFjwTSEICIq1evlosvulQuvfRyBQZxvesNiyho'+
                                          'JMtlUxpNHOXQvqwDWOb/k21JY4jry9/ztSz9svSgL9wHUoIPedfB8s+f+Wc1YMoRkVyNVKXiACRZ'+
                                          'oB27rkyRarzmkkdQ8t7f/U5+f+998vjjj8X+EW0N77QHw31YFB5yQfg6PxiErSBj6dgUBmBRCJ/n'+
                                          '9IYQ+8knV+vCQLiNxYzcEzdufLyh38fGLS9FeCd+0y3Mb8fck6AUNxiFJph/8yj3BlCyivRgVgZI'+
                                          'CaZ4BSsJeK8TTviezJ49W9VysaEsjxaZMrVPjQKMmKrWZKmnJZbv0jD9MUORkYKoemEi1DEz5N74'+
                                          'Dvo3LwuiP4KGTz2stz4j0sDTsYGxwHnuDPfxPICLWhr09CJ3g2RSW9ZI1XYcgqE0KgVXXnm1XHLx'+
                                          'ZfLb395m0l0aajdkIERPlp8X3AntI/CqAK5xr+sHxBDdpb+Y8+M5/FknBYXn4l7gQP6P88Tn6tI0'+
                                          'I1fHcMaZP5GddtoppmwNBYqTiN3ooU4g3MtaJUaR4iXSxA2kRi5+Ths2rJc7l6/QqAC3oKOpQ9Od'+
                                          'TR3Rwfnh+Rf87JfnnT7Zm29LOJ6xATjisHfmxvTq0VwTrDPUqcdGx1WGes2aNVofV/UfQ3nDIq+q'+
                                          'd9XFEhYqvOiQq/xwYRFBJihGHXrk+hxMSRCOYSxTBZMVm9iiyv53JwTJggXfkVe84hVqNLBY4W3h'+
                                          'obffbjs9N+xNRikVb1tmGF8Oi2kAFN/AdwzHdKOhIbPn9FbRaMWNWS6nsRyqNfKSt8dGV7ZeMFAU'+
                                          'Q0E0xcjEsACJuEDV04OOGywYNobkwl7+YDhuu/V2+dGPTlND0CxdN5Ze8bmZktHg8feMGnh/8Fym'+
                                          'AMQ9DPUfMB5A+Hm77bcrrqOyAHvl/e9/v3zyk59QA8vni0dOUC6mdgSuK6jMqJQ0PSpS8ljb9AVG'+
                                          'FXcwvCgjSBz+w3MeuP9+Wb50hWInul5gUMedm1BvhMigsTB8lu/96tcXr5rsjThZxzM2AO8+9J05'+
                                          'crZuz7vRi96jJbp6MAjDGglgYWj3X1gcUKcFIIabh01FwJCblKU6enOKS7DTj51/BN3KzStE6ClJ'+
                                          'hfOhEaHB8CqAnHTSCfKSl7xEQ24sfLz3DjvsYN5WZMJkHG6ClkYjlieXy368koUktkcEGqKz3TbX'+
                                          'cqh1OqZagquU8n5uKKQI8ORNB/5MDKXp7EBLL4wbYBgCwmfO58N5K/LuWopVR9XbnnYQncfj8PgL'+
                                          'L7xETj75FJ0ViE3FNIrXnEM/bBMOa2qFa4rX4cZndYW9F6yEEB/A54A0eKq6juatgQH8/Oc/1RmC'+
                                          'ZlyLVm+NOMJ916pQuxXTjXLub7hDXcul1kdSsA/bXlpGdKDOJBjCO1eskLvuvNuGmuLe+OeEkWi0'+
                                          'lCAFBal5555/6eLJ3pDP9rHJDAD7y1c99Ihaf2zeofCFYZQo86libLhZaAii10xKQh/ltlR6VqL4'+
                                          '9E7kqDOc40Llz6wcULDSDM94DEfxb0QA2weP9OMf/9CfU1FCym677RbzbxwKPmEeQc6GmNRR+HxC'+
                                          '45F5JJuIQ6VihrQEOsuKOtgQaZKaMGaaqKdWpeOwwRiCF+25iZ6fAal5ZAfavL1EowTk9OipbzQM'+
                                          'FKS3x4FzN6MIo2HlU9zxsu4f3vf73z9JzjzzF7HngtENvDBxEUYENCS4BujHIPeinPvT+JJLAPov'+
                                          'uv6gD4j8/xvf+LrMOXCO3guVH9O+hJZ+VgRNOok4tdfB56ZBpSYkG8cYddG7M+LCAaOn6UwsLdbl'+
                                          'xhtulLuDIdC0TiswqBAZFtNsKCnroVajcfz5F19x+mRvzGfr2KQGAA0n6ECbPn2GbMAEmnaupZ4n'+
                                          'nnxK676jyvdPIrhHPUAsAvwthoIikQfAcB8LULvHnByExxLgo2EoI9FMG7ig8Xi8JxbF+973Xv3C'+
                                          '8zHDbr+QCrTapolHj1x0sNnCS9IkDsdk5MHcl6Ia1uPQ1o430zKwML/MFiR4xs5GrFlcO/2cYpuW'+
                                          '+od2/mYkNMf16oGlCLYhEZUQ/KNRYElO/BrCw04Q9nCyFr01Nt+DD66Uz33uOLn33vv9vBK9PvTk'+
                                          'OFhxYe0fFRV6/XI/BqOCnh6LhiAEQmr0X//1X8pHPvJ3+hiIv/L1Gpq6BYOet7yHoKlrBmsLU4tI'+
                                          'IqIRaLVbpXSnrelOrFKwMgHyVKutxoTrDkbnmquukZUrV7mRzv0cnBEZ1mQ494fC1/EXXXLV6ZO9'+
                                          'QTf38cx5AIe8fX2w6gNo/8Xmp4BH23n9+FoT0gKdGe81/aaH0k8++YR+R+4PA9DUMdV9caMxh8fR'+
                                          'VsS8FiMAHMQMyBYkaajtfQhYkIhGWB7E91122UX+7bP/KlP7+2X33XeTvfbaK3q5guyT6YIoRmGx'+
                                          'h77p1YE8lvoktwWcuJe0MqSxFYF9cNMyKimr57LUhcWLfJ/gH8g92MyZP466eo06vLzEdASeTEU9'+
                                          'XEfBKgmNuEnaHkUoIFqpujEh98BHgoXrrqQl7bDcKCf/8FT56U/PssUR3hjXr2zI8PqIDPhc4i2U'+
                                          'Y+s4Yo8NjrUA3wzvj8+9zz4vU+AvGlJ8pmYxYowhPAwwsCQYH4T5LB339lrklXtk1Xa6Na6Llg5L'+
                                          'nIG6C880lDXaZSVVjx7wHSDhdddep06L1wT3AJHBuKeO4ev6EGEcd/Hl1yye7I26uY5NUAV466Jw'+
                                          'o+ZgwyPUxyLHRe1oPbYRQ3wcqgbkqD8uOlhqiBAQ+qHej41Bqi+JIQSWcJBdhnBTZ9P7psPj8L6s'+
                                          'BrRarRhtYIFShWjmzJ3kmGM+KTvvvLPM3m8/mbnzTLvpHSO7YGRW6iE2vDIuDvJvKzfmcdOUBTIY'+
                                          '6jPK0MXf3aMLz0g2DTdMDbEINY9RA15fewEQ3npYjwWK88D4bfPuRW4LQ2FGph09uHEAEg93M0XM'+
                                          'cylKeeJciyQ1D0ogUrzm3nZP2nSjCiOxePH18vnPfzliLgQJqe4Do8Dohzk6ZwEwApvi1F5EWLmn'+
                                          'd/u+Yl/56Ef/QV69/6v0/cimJMWZ9HBEOEgvICfH+1lxngnVo2u6LtqxJNpwUdlalzkB9EzgepB6'+
                                          'LXlhHHLvsMT9uuWm38itt96huADucavdVKNq5VnjTIT0Af0jn7rsimtXTfaG3dTHMzYA7zr4bccH'+
                                          'K30cwJj1GzYq5xuLBMYgc4Ve/A1vxVAOFx45GRZvV1hcrM2XmWllTIBenkMqcIO3cWVZUn/xHIBU'+
                                          'eKylF0WZDccBb3mzHPjWt8qb3/xGedWrXjWhrx1eFwg6AEnb7EgHegpePHL4NDFQLicppRklydne'+
                                          'Cu+Reh5rIWfH6/YVo/Z28pirdnwaEhZiqmSllufqncIbddqRNKShasnr2TkVYbzW0lvNiNDjxlZ9'+
                                          'EeOwiKQS2ZZkF3YUG5jYxgtjc/c9v5OPfexYNdIkVhFzgac3+XVTG7YqRK6gbo9jMUg7asqorEQN'+
                                          'B9UHCOvhkIMPkn/85CfUIBceu668BRz04FmGpqeSwIi+x7hGaBrtcDZBZvyPWjDa2Lgjo6Y/0d1V'+
                                          'i9UQGEGXIS+IRXWjJj/00MNy+WVXyvr1gz7GXDwqtBQBOEMw1IPh8x1/xVWLF/xP9seWfjxzA3DQ'+
                                          '22aHC7UU5RjkcLgpEJ1sOfsO4VthBHK1rsj9RoZHdfMbAGZNKlT0ZSsw8kujFo9ESirLfMw98Te8'+
                                          'D7wVowfWn/G4ffd9ubz61a+Www8/TF7+8pcpPkEDAy/fdqQZP5u3rlnYLaJUZm5yYgK64JJCBQfA'+
                                          'lpIHffOwFm7ofOZGrO0UYfESoYXm+F1WMiI4F2udzo16HBY6h3WCNdckUQd8CIJ5OjTFNrkapSyL'+
                                          'gqpqGBsWAmt/hRQTfGN05YAroy5xgA2fFRvjI3//j7Lm6TXG8gyvh3skJSB2xozpHoFZVUA9fjjf'+
                                          'phtYVHso7wZDOBzuE84FI8c/9tG/lw984P1eEh5XdSBt6W42rF1cja+tUl577euAIXIcKfPUb1SB'+
                                          'SZtEzJWtKZ1fW2vKMq4HnA9K1TA6eA7ZjFdftUjuvutunaWI1wWfg1OP8xxalaNo574+rJMPX3H1'+
                                          'dasme/NuimOTNAMd/M4DV3bVqrNwuYeC5x/Xcot1m7U8rIN31bCxZkxBbFiW+3Cz2eILY8HQEpuJ'+
                                          'IWWrVR4zVXQJkj/ONmLy2nfddVfZP4Sac+YcIEcc8W6Zhq5A9VA97kWt/RZ98sgtNSwWiSU6huzM'+
                                          'zTOfXUjDw5IjgUumB+z9JzBIEI8VgHL5r5z/FtiGcZEJCLJCYoYn8UGeSYwmeC7Y6CiHxak+nmfn'+
                                          'bnTxWTnyO9JqhZWCQhuA19UeU5eHH3pEPv6JT8tTTz2thgm4C+XF8Tx0W+JezgiGFS3PVQ/NOS2Y'+
                                          '6Q7VnnEeKv7i7EoY5eOO/6LsuOMOej4wwFLy0pz7wJwfHtnmCbT13zZApmAMMvrRSM6vX93Ls6wM'+
                                          'dLzy0nEMRs/ZQcoVy++Sa4IhIPgs3g+izsuN9sjY2GC4vsdfdc31z/loYNMYgHfMOT7cgONsFFVL'+
                                          'vSJVf7XE0my5PHUrdrTBIKQlvjg8ANFlLCiSUojo4wueHawyzgIoy4Az1MXz4PUPDmHmhz/0IRmY'+
                                          'PqA3GV4Ie4s3MUmttGcbLjV6ryPvTB3KAhgWmedR0ac8Icc4AewPKCblkraLA5sfi1cNTJpFtJ74'+
                                          'BHN2BTuRBnnJUdlsGv53In4CQ9DJqQfAvNYWacWNJI2LbeqOnrvNVsyc6JTHdMHOO1cKbqdkAGiQ'+
                                          'Vq16WD7/+XlaKcBhAiVWdqx5FIX5g+LUX+Azb37z6+T++x+URx99zEFVMwDaEj64wc/DgFWkEf/8'+
                                          'mU/LEe8+/H8r3xmHIaUKkmoJaKm4ZeAoeyAq3mlKhqQ4xbnNsnJm+AheKlKJc0tbasSZDD2VJ598'+
                                          'Sn599vk6PTlxzgDxGzOUVrUI6/2iYCg+dPW1Nzxn6cWbxAAc9I45UAJeCUnqoaER91KF5r+JU2TS'+
                                          'P22abFi/IY6p1g0wNq5AGBl7COcp512m9sKCAyik+ATD/DIoB3DvTW96ozLM9tlnnwmSYBiPBTop'+
                                          'PCcVd4DWW6hpi4ylxEL40jwM6cosMxP5Lmvqk+ZL8kmtqxZxCyzmUSfh0KhQD5ELK0qaifVLsLOP'+
                                          'uT/JQgC0qJ+AzapgoUdHfBx1FfwCWQXBwUh6fq2wNBsRSMVRTAguIg9SqR997HH53vdOlLvv/p2G'+
                                          'zrHrMk00Jco8fJ/9yn1D5PVKlfvG5jv/vEuCEXg8fka8H/o68NnNEDb12iEfP/zdh8m8EA0AKwIr'+
                                          'k9WJpjP5tBeh1CGI81B8wPGWlldYxhX/6Wj6UeT8ouAqDhVkUePXUowh9a7GnM1YHRtJd/Yvz5VH'+
                                          'Hn5UjUDiKVfqg1TxO6hXh2v9ULhPc69ZdONzsjV5k0mCvf2tb9aZ9MoQg3hHuDhQpoGlfnrNGr1o'+
                                          '2NxPPPGk+lygxBsHh3QB4bGw3IgK8BgciALgScgww8WnJp7WkL2mn3tut/fee8snPvFxed973+MN'+
                                          'Op2og1cQjaq62Ix8U/ANLNdMI+9fvZp7IgOcKnFDEqxkHwMNjOX6ubMP25F6TFYiG4nwN9KD2SZM'+
                                          'nEFBqZAiRbFU3ayFVl9Zncd0Aey1rbGoFevaBBmtvJXHRh7N9YHYu8fUaCLzjeWAYZlinaaJ4xzj'+
                                          '+vPq1U/LRRddKr///YMKDuJ8cc0w9XeXXXYO92BPNar4PBwLDjD4jDPOUo1CbCLcGyD8yOPr3luA'+
                                          'jayGJ3ym3XbbVU466XuaUiClQco05uVGlEeVnqxsx4ZLxfXpeTBNU7Xj4RHp7euJ+ol6j9GTMlbX'+
                                          'cyDBCHwIdCfWXKBFiWDaf9FU7AGvd+GFl8ryZXd6ymfTqfk+iG61P0NnWrSOvmbxTadP9ob+nx6b'+
                                          'VBX4rQe8YVG4wXNMo248Cnuobp16FyNiNF2eWsGyNNObgM2JG504qIMDCxI5JgeAEJWnl2Zr8Dve'+
                                          '8Xb58rzjZKeZO6vIJJl25UoC3rvm+IO22qZZ3MQ4LHeWGMIr8w/IuSvYaFmpWon8ApYecZCjYOfY'+
                                          'dE+XxbybiP4EhR1f8JqDYvM1reQ0pa9XN6hFD3aeFoH46yrZpxnPAeAgjZX462mVICvYe6wAMOwd'+
                                          'HRuJLD1lEJbC26oqD7WMd584tbg+Hu8xnvOb394eIoF79HPhmioRLHyHUYHgKP6N+wnBD7zP4489'+
                                          'Iaee9lO7p0qWaup9BVg8pW+KRna94XMjGsTn2GGH7WXB974ju+26q34OXAfcJWWGZqkCjior17EI'+
                                          'CNEgz8U2tn1ubb9ytF8rMom4JmGqhg/H6MiYpiCjCi46IIh7TEWk8N8tN/9WrrziWt38qZOKDKrJ'+
                                          'XbTF2JrheQsWXXfzc0p6fhMbgDfqRKCw2AaysABQVkF+iH50EIVGRmwjrw+5VZ53XOSi5TTdWsxH'+
                                          'EUVgc0G8gxLfI84PJ0hIQspHP/r38vGPf8zUe5I01rNr2gHXnsAmxMJJXIaLFQUaE4acWq1wymye'+
                                          'T5yBJx5Kli9fHum25h3o8blh8V4iBaZQVhPCxR91VHtECTm2iElvLnodPGxP0kiDJQswzQoCU8tb'+
                                          'anm+RgAyIJa8AUZDjGRazUaMKgrlXxg1nn8rvlYxQ9CYmA888Adl1KlXVpZeohEAVKFwbXp67Xrj'+
                                          'fl5x+TVy0023qgPA47u70dptnn09tB17+/QeE6NB2nfyD78ve+25lxllJzRZNcQ4FnU3wnXt9mvq'+
                                          'dcydMVl1JSWcF6KQbs4rbBk4jb83lJZtUROrBIycOs6xoBFYtmSFRgO8tkzlYPRIyNKhtM3WmeH5'+
                                          'n1x0/c3PCVxgkw8GOeDNrzs2LKL5WKzoBcDFx/pHSIioAGowa9aZKAfZctAKgCeAYi16ByhXVeaT'+
                                          'M/x3ZV/d8F/84ufkb/7maN8YRqvV/JQNLR5iW7OQtaEaU7HldN3cN1LLc+kCwCuX28qGgBEDm2X+'+
                                          'eHCGLZCCYkrcoNUqFI0ZLdCLV72pBc/ja2pZzDUKuJGt9GfAHJmKPEGGuVbNyEugV6Kv0/TSmmIa'+
                                          'IhPyfvs87cgjKMqChQaC9kG0KR9OpWWLWu5Eo0247tgo6Pe3jkZrWQZmAcMAL/u97/1Q7rvvgWh0'+
                                          'mbLEa6CCJrkaLJwzUrF5X/6ivOENr1ODbvJnweMPD3k1oh7z/HEXXdVuSQCa1YInMMTHjxuHQMlV'+
                                          'iSkhY102XJMCz+FnbHLqdI3aA6KdhWeffaF+fpxPefdUPE1T4lK7syJc7wMWX3/LFm8ENstswDe/'+
                                          '8TULw0I+Ci+PfMw4Al2a+6EOrx154Z0BDqYekgMgfOLxJzSExGMJ7JVFQgEe4Zg5c2ZYTPNlzgFv'+
                                          '1hujpSaVz7aqgNa+e4w2CnAX+7jiJcnUVXQY5lOOu+jXL6bi4ig2vpeopNg84u9diIUUXAE9iDJD'+
                                          '9afRjJuWlQtGJ8WmyifU9fmYEfTBd3HeYd119fw9lTKcRUIU896sksXuv8j4889oKjudUnmuHT9/'+
                                          '6opHOqDVORJNjxKKaUwSRUdMtKQhK1etkjVPr1XlXxwm/mmMOo0Gerpk9eo18rWvfXfC5GBjhZo8'+
                                          'etWrH406G3xMI2Del78ghx9+qKsgFRERoxsqNsEIUHKMFQGsL1NrcuUjZy5qt2eaGU27UZ/g7UEt'+
                                          'rlQ8bfPrk7hs25I7lsmvf32xG+fUt5CVfxkN4krWxxsrmu3mAddt4UZgsxiAt7zxtQPhoi0Kef9s'+
                                          '0cYN06Jbv36dhuFcdMgBtf5f69YbpBOCmlarN+LKRJUgeH8QT/7pnz4lRx99tFnnTh4/BTxNVWXH'+
                                          'RmO930QrLFdnNNHWBhgL2S3kLmr0ZQVchsnlsqDl1K1YwsPz2dxTFsegAWloq6tRgokLsEuQopnW'+
                                          '4ZeV6L6FGhDbbovBnQUtesx74RmxdNxoJmkxmINMx7ZLh5MwE2mxecerCkk0XpQVs/bdmn6HJ6cY'+
                                          'aZksxP4CGGCAhIjisOlgpGC0lAaMSACGILzH1VcukosuulLPseVNT6a72NR712nn+vOoXsealj8R'+
                                          'Zcyb9wV561sP0Gup0c24Cb0CN8LrszSIKAjXDArJMEZtNQ6pGhgYiC5Sw5PEiUG5ktWQKhA/0bXh'+
                                          'ZWJWBRJvtELEumTJcjn/vItdVTlX3Ikaj8ZfqWoKEd4nRAKtA667Ycs1ApttPPgbX7//QLg4i8LN'+
                                          'ml3Tct6oKdJqc0aPosjw0lQJbnJabd6JopljXg5C5EAK6j/8w0fks//6GfWsFO/Eha9UTTQTlrjt'+
                                          'nhPehbVvo712Sso9ZrlxE6MQoDLw0liLbzm4hwPhdJYVwqTcQHGkeasdvYwJoJYHbiZR7qupIWo7'+
                                          'EowMaKx5pCORm1DmQBAANSluMzIMibFJSFfWlMkViKLh8oij2Sq6KlmVoAgH25rJrSDNmUaR/Qww'+
                                          'Ik3vT0B7cScv8eu9uQfGF92fnUjyamnZLU2MSo1S7Of+7auaGtat884eB1xhjKlA29aDp3KIArB2'+
                                          '/u2z/yzvPuIwPTeAd31Tepzia5GU9gU4jwH9KFOn9IUIdFR6+7rj51Rj4aSvtqsy6+fPkqivoNfH'+
                                          '+SpqGDudqDNgeoUit9xym1x+6dXS6ljPATGWSPTyqDI4tRWNVvOA62/4zRZpBDabAcDx+tf8KcaF'+
                                          'LQoXcXa39uSPqmXOKmTaJWoEwA0gmafj5BSld44YMEaA7C//8s/l+OO/JP39U535ZlbcwnSJObje'+
                                          'XN+8Fnobd75V6hq0iMI8aKVSjRuZoXQxiixxxmA9yl7RQDFfx4amKhCBPhxlLQCG+Inn8cyjmTpQ'+
                                          'ACRzEUwaDI5Sg8HAJrZhI4kuWJYZSf81Y5NGAxFD2kbTacZJDN+lxGZkBaHVmpjGcKovw3QaCe1B'+
                                          'cLnz3Eua1EKkViEMJhu1jNLd8uss8sADK+U/vnOSh+OsxOQRDFZDheiAhkyMOIZr9JOfnCL77ruP'+
                                          'GTslRFnagghEz1ll0uzz5C7CwrJf7n0lqpzUcbzEh9ZWq2aQ8TP1HlhKhk1uO3CsLFKPEs855yJZ'+
                                          'GqIBSweKKgvXJLkZYx4JXH/jlmcENqsBwPHa/V850M47i8JFm011YPTMA91HStDfP01z+6Z7TtZ0'+
                                          'GWJioyMqQI0faD/AHG40stEqTiohHmBcf/OWWACpAmkWxuKw0M3yXqOtViOr0G68GRF2F9Ky47B8'+
                                          'vtDGIxDHYSDcVJwHOEELwDcPsQBumLbTWtk3wOGdVa8ImNRY5ulQQ1F2huxY+FigZRUkeq7YeOSf'+
                                          'Uw2WSIw2cHRcQ5Dnw36EzMuIDHGxkdUIubinds61DNdoaZ9DYQBy1TToRD3E3Ik+bKFGx95JJ/6n'+
                                          '3HHH8khEUgSik0cVoMSbxhAd4bq1HaPAe5/y4xNkr71eol4axhTGbljFZ0yLEh190BJgFYBg4Lhf'+
                                          'G8MaWhrmK1lNxNWFmjqrolbN3GiIlawrhstkzmZNnaCEz/uzn56twKauKTcYlczG11eda4KIJqRR'+
                                          '1y+67uYDJnvD//Gx2Q0Ajlfvv99ACLvmhwt6lElDWdhLFh42C4ZW2ngtSwGA2HZ8QX3961+Vv/qr'+
                                          'v/BuMFt0DHGbbvk1F+5YCG8fzJpxMs//SPBp+AKmEq/SUz30tmk7WeQPVKsM2W2KTZnwQyNUDLtI'+
                                          'XMhTfBPbayJ/JpWZfQNWEai5ESqGbqbu+XBUvPWXBCZ6cOuZqEWyT5IWQ1ITnyYUiS6tVoxA2s6h'+
                                          'YAkyjhZzI1U2fhxmws8OinDT6/fGmMxt6pFv9kLFqO302qb3URSfn9eEEc+aNWvl85//un42oPTi'+
                                          'mAhayHEfkSogAsRAEwWNfUhKx5mVv/jF6coXUMMZacAu50bNAy9psjNR29WdBQj6N6IosAO1IiTk'+
                                          'C4jW96usVKTGB7Fr56K0fp1Jkjrt1J+qIG75GmCtGd3cHI6rHp159bU3fGiyN335eFYMAI9X7rfP'+
                                          '3LB5FoYFOWDhsYXcyMvWrl0fN5IOFIVXDRfzG1//mhx2+KGFaEcnjzk+yz6qw5sUFF2mArZxjMJL'+
                                          'UY+RkTFFpCk/BQPA8lwZ+WeVoGhMkQlhPzccGXrGLLTIgbX/8qCSQgG44m3HHmKDWVYS7yR12Bhp'+
                                          'xgTktGUM0ozsP48c2PtfFgLh65X19Age8vF8P9v4uROPxEuSzYjuU6OfzVbm1ZveO2A5Nz8vI5uG'+
                                          'gqTeLOUsQoq7KEHJN8/pp/9Cbr759pCKjfjfjfyE4aYwpvh9LNOJREYmvP3us3aTE0/8rkaEpF2T'+
                                          'Nox723DvXwCjFjF6YmBGxkuPid9zAIumWmzRUwQFdYCp/S7zCK/p/Qp4Xziv0079WYlYlmqqQ25I'+
                                          't6YxVu4M5/CpG26+dYtpInpWDQCO/V7xMoCDx4aLeEy4YQMd192jSAi/tt9hB5kX8n109GXO5iNy'+
                                          'rm2aIgUVFzk5R2o1jVmHA5trvDRnwKSnDQgyPfwuZbmx9190IRhSTzkwZaGV+gRyV+QlK5Fa+CA6'+
                                          '4SAByIghNrugPHyDz8s90oE318pCoxlbfKuUssosjeBmZjlOJ/s6/ReHPZ+ls0LeihFB9OppgUvQ'+
                                          'OJX1AnDgvdulch9xGZYqoxZfs+FGkR4ydw+ZR0DOpjohdJaINaiRQNTRzpUB+JnPHB/Ppe5y8V0+'+
                                          'P2Fs3Dx328t8lq6YYjPu28v3eZmceNJ39TF1Tx1VGNUZm7q4/Z5rJCgWZaXeg4CwX9MClHgr1dhs'+
                                          'RENqlZCmpiy5v69SrmViezKes3TJCvn1ORdFRanEuQaF5Dyi04qSn0JkdeSNN996/mRt+vLxrBuA'+
                                          '8vEne+8591X7/+n8cLNm0ZNuv/0O8oY3vF4OmHOA580W0lZKWgCs6WvDh+fpBI/I36c457g3jOA5'+
                                          'ibfm0qqjJEnDQg+lbaPUAvROPPt9VyTFcEOzNGczCrqiEdPqgtN/ywpAXOiMBrjJSEE2Y9aIMxPS'+
                                          'tBi9RQpwrVQx4NF2SfHU0x0CfVzIzRJDkJLlHA7K1MIEOLISyaft04sa8bMqMSgOD0kjroJzbzVb'+
                                          'RT7vA1LaLt+dsQdC8gjaYUoyqMKnhvD5lltuFwp34h5Rc4ESchWPvKCNAGMDQNn0/YbkL/78ffLp'+
                                          'f/pHJwC1zfh7Uw/r/mMqPiNxslPC6UMiccIU7h/LeFJqRWaqaDyAPKYwqlsRnjOupdia4iTnnH2R'+
                                          'LAmGgBJuBJeBNVC5Wc9nrD4YrsvsEAmsmsz9h2NSDcDNNy+ag1LhzjNnFuF1Wsya46YkwEePz7Jb'+
                                          '5mF3x0kdzN8R3mUlmWm+Ntl75q2yUu5q4bFyxB3UIlOQzDuSk8rKxGS00XB0fPQ2y2q5zz7EYiZf'+
                                          '37xvSw0WgTZiIcYQbHm/gm2eqKBcKuHVFRwrxngxv6fWHw7OCiBDkIedgziHAQIaxVwF82qVEi7R'+
                                          'mdBZmLtCMpuIWuUQObflZBr8Rbt020uURVQiUZEIXheNYsd96d/19XFOdU+LlHMfXhv6EpAPbzgr'+
                                          'FEYAw1xQAsV5gYH4zW9+OTiMN8bQn83Rymh0tSTOXUREkmbGVFRBGagHdUSZinZOFZeyr0SDkXsL'+
                                          'sDVRFbJwTBsw58KwkKb84AenyeCGQXUUZa1J4gepN0SNjY2vWHz9zftN5v6zOzaJx9VXX7p01m67'+
                                          'zcZZ1KpdUf/ftN/aUR+ACjxVz32JElOZxpRyDdmlcKh57nZk+lF4xPLWTpThwiVgZ6AN4rDfYQFg'+
                                          'IVh+n8XHsUeeCkCW/0r08pmLVWAx4P1ARqHXYNmu0Dm0CgKBIxoWknGohMNBoTi4sRnmMmrIXBA0'+
                                          'tjO7l8LCt9Jlw+nVDY8e8shy4zUlsahoh7aQve1lQxolGtNObsg8ZcsgrZ1lSSxzqv6gC5PqjEQF'+
                                          'STsuhlLXe4aN85Of/FKjADYmISzH33RGwNio9E/t11HzCozqZ7XIEAYC/SUgBJ15xo/lRbvsbGmE'+
                                          'gpy5SoIpeAldRwflTChFIk6i9f3EqLwNxwharhfBBirqBGDWRXd3LWIZYAxaFcmdVrgXKx9cJaf9'+
                                          '58/FyseiWAhZhvgdrk/NuRtDw0MLbrrl9kltHpo0A3DVVZccNW3atIU77bSjL7RKRIJTX6gM4+1E'+
                                          'k5I4g3dkOYnDAMGqh6RdkehjrD3LVXXUVF5o5bfY/plPlPsyz17VhcgFqVp9HsrnzrdnNPLHuT1C'+
                                          'SdU7TDkarCJkzpXHaZt6caGFj0Pr1EqU6o7DPxWc64gKgJDERM1BynpRVJPNVJySo+/hVRZSgM3T'+
                                          'd7TUVZ6qRFzAsInCkFRcdJMRD6fskMVX0JtbXvpLYkVBKb7ikYNYaN1sNV0N2Eg3+N3DDz8qX/nK'+
                                          'd23+A0aQ1RuebljqU6ka/z8aHeXtVx1jsE2LMeNn/ORHHkUmDhx2dLMp0zFNIgHIBFgtn6/6jERy'+
                                          'A4pr0tZKhBk+Y3TG0qqrGSnjFOrH3q3I45KLrwrR7W1+/9M4GVpHwfu/lcwUnh+u9ZHBCEwaHjAp'+
                                          'BuChVfcNPPiHlfD+szjOCpprFUfhTcCiFTeRASpp1NijlzRln3TC8IoCla8WrbBV5mKZLkDTHKw7'+
                                          'V72rVPpK4nThjoM+JOiQWMT8vTyZCIAU24sRSo6P1yekBESRyXnnKCvbTBwQ0o4GysL+elQaQp7J'+
                                          'oR+cBBznJnoTCucIxs5Fz1c7DmIyBC/SqsRD+yQSetjM0nShEONLFLLsZuia8XHM6ZnWqEyZYhB5'+
                                          '/HyGZzScK59HIFOHmiZpbL/+7nd/JMuWrdDUKHUaLjUOcm8j1647dwQsjVLyHC3nRx/1V/LRj/6N'+
                                          'vXfb2IRdPpxWlYLbEAmhV089Vzd1H634OIiYxMjSIkKShmJ05CVnAom2JPIYGaDy8a1vnRANWVpa'+
                                          'o+YATAY+tYrGYLhOs4IRmBSS0KQYgEWLrjg+eP/jpk3rLw31qKoHoQgFkWfmtOUcnwcsOjwGN0NB'+
                                          'vU0jcYfS4NTwpxRYMfgjjRuZCj5JKWTD5gZYaPqFtdhIRK1CG1A6Eh+Txw1HSm8nloPMUKSl90iF'+
                                          'E4cMiGtoRxojF0YqbWejtbxbLqukhX6fNwNx2ErU4GOp0hdg+bPZtaC4iEU5BYBHgk8aN3GUGBeJ'+
                                          'qQ1BPSEhSY2ySYXR2OQuY1a08baMQuzkIwVz/fVvvvlWOfXUn0VadNX5FtoVqbMmTTNSkoJiTQ3/'+
                                          '1L078IEzzviR7LXnHjF0twlATl1WfoG1EUPfobe3y4y8Xw8yEFFVADbQq+3nY3p9SFdOHZ8RFw4p'+
                                          'ooS81NGZyO23L5dfn3OJMF3Etcm8jGlRp8Tek+Hh4fNv/s3tR07GXnzWDcCqlfcOPBjc/4tf/OIB'+
                                          '8To8qZRtb8et1sjYy4oOOIRNpSk8pqtv47mJytpzrFTHi2uL20NnmnghmEipL7sMZNJpl1iU0DZM'+
                                          'gCQaHJwLyGYd9CywOlAuK6ax6pBEEk855GZvAFFnlgW5mYyFyOGhrZj/iwt1EGjj5N2obuTUZ3ax'+
                                          'EbSiQIhxCJoeaTRjBMKFHdukXamYr4mDtGiCfwRb2d9gryeawuF7SmPmI+PJBsTnUQHVJo1NLscc'+
                                          '+0Ul/9i1dram6y9oiQ74DrENJ+mYwTJjBE+/664vktNOO6HgNLSaXoeX2BeBazU8NKLRWqrTiOuR'+
                                          'IGRhfbfxRXq7tdKANALsS51H2GVVhqYOam2686JikxOyUsMUTjnlZ7LyDw+JpaOp81wKA4Jr1+0K'+
                                          '2OFeHxiMwOLnvQFYdO0Vx/ZP65+P+QFllV/w25nbp77xy5x0pgDcqIVwRTuKQ1BNiB2ARONJArJc'+
                                          'nsq5Em9I4cE48DOZ0NLbjlWCZMLrWYOO0z9J+3S2IBH+OASEeXObHYpWBWCTEZ/La1KtVJzUkjnP'+
                                          'IYu0ZJ4HIxFTFypyfDUOpZFZ3Pw0RiYNVo/XUKQYQ25sxSyWH5nf04iwEtDx9+R10dKfd1XSEHGF'+
                                          'KZ5SZ6RhIKGKmuZSoh4n8qtfXSjXXHOjR13mnfEOOuRF/F4jQvB2XvAF2h5pjHkj0fBQSAX+5q9D'+
                                          'OvDXxnvwilCaFKPNyG2olIQ8sOkp00Y9S1wHVCVylTRPdeK1tmWLO65q5vhLJfYHqAaDRgw1efDB'+
                                          'h5QgxEiWDoQGg2xTPD5EOA8FozI7GIFnNRV41g3A1VdfunLXXXaZZWGrRMGFLDXyDLXhKJpB9p+C'+
                                          'UqVJv6nmbASc8gkyYHgtagPYgIxapLGmXgduupetVIpIgP0Dpk3YJzaGmhz/rNQgJJEqSw69RQ/j'+
                                          'UV6cvACWvcobiiKkNjKsEVVlOACFICA7++znLJanrLGpqLt7UDOBecjutY5PEmZLNRF7Vgr4Gha+'+
                                          'irc6Z/GxZEuq1r/n72wAKo85V0ERB+RoaDveMagYQ6d4PFMTpHy2xe0xjzzyuHzjG9833r+nKAjB'+
                                          '1ah6eoEjdWm0jst9YS2hkQhpGOr6qLycvvBkedGLZmpagOtreTsnVI1plMYJQRCyxcjyQhnYpkM3'+
                                          'XctBlYp0fZHebZqB1jSUT5ggjapFFbyAiuEwp/z4p9r8xGEmlF2zhrRK7CJ0sZt5t/z2juOftwYg'+
                                          '5P5HhYu2cLvtti1JclUjy8u6rfLojZmLKzaQpTHsJRswcXkqe3wttgDbhsoiys5WWvO6ZnjYY8/3'+
                                          'YVkPBw2PLjbnJZDTTXpt0eWXCcd6k4REso+9V8f7FQzYK1qFi9l4Wo93kQvLv7PYVUYOvm3UVuxh'+
                                          'b/k5FaBeGolHifdb1LxUSOVgfjaG9eqF/PwL7kKBvVC7wMRB2hqm6zmqkeM0oVSBwtyNJQefGCCW'+
                                          'xBTFrmMxq8CauXBfaBzt/ObN+448tXqNlSzHG/o+5oUlbljT/Pf5f0lh0PEIGAy855ve9Dr5xteP'+
                                          's8+SpdFgcFCIzVFsuh6BFACjl0jHx22QCqXFipTScn9jLBLYtHtm6cSYN52ZJXnwwVXy4x+dGbEm'+
                                          'vT9eYjSg2qXFKoZzNNut3W/5zR2rnpcG4IorLlw0a9buc+hhNOys1Ix+6jkda8wE0uIUnmrRsWdM'+
                                          'wFYs+Zmabi1uSDLcaBjY35+khcR36iNnity2CNMIvhEd581nJMBQHu9PoMxQY7aB2ux5LITy1J1R'+
                                          'b2s2bMMbkJjbsz03KvymkdZKL9/w/nyy/NqdQqKLcwXpkaPRcO/UoUemBy4RiyxiaEbjxs+SZQRX'+
                                          'zaMnJQPRbNLb27kY1TiNr6Ohvb9eysgudxkwTxeYUqihUawjkSuvvE5+GVIBiKOiCcgMR8uBvFxL'+
                                          'gtAxbLi6MQa+NJo2dg0iIpx9iM/w/e9/S177mld5v39qEUdieYWVNu0ex14CMaKOUY1NeakAoxOl'+
                                          'L1sZuCjf0qDp31DmbBgw6NQBvUY/CgbgoVWPRLHW3LtF1ZirkbG1jSdtHNx4+i23Ljn6eWcALr/8'+
                                          'glm9vb0rod2v4FFaifk7SzDlZhxTwE3jcBGW4DQVKJX/mLOTMYeLSZKMMsp8w/G5LP8pCUXEF6DV'+
                                          '4Ik9sNnGSs6U7nKufKUS6/NlZiGND+cBjrvSDwwQ82brGeiOyL91FVpJTVOglHqD7dj6i3CWP1N5'+
                                          'RlMTzWMLtSRNmZzUUuYmMDqg9FVZ85BMvrJgqKrjVIuuNhyGHUgEQg1T8MEmY3U9r/JkI3pda2Vu'+
                                          'xtC/0A+wRiY2T+G1iMWgP+Bzn/uGjo1rekrEvgiT7kpNFTk1gpfhP3XvJ2nF6Alh++zZ+8rJJ30n'+
                                          'GghEJFw7qArgc1llx3Ae0qnLm7c8kSrKqbdbjuYXjEDDeRCl4XpUHYg254IUAIBgZLvGNU7vX40a'+
                                          'Ai53f2BIBRY/rwzA1VdfMn/bbbc5Fqwu5sIWNmUWhiUS6+/c/LaQspjbUr9ffJPSu3Q5f59pRFSo'+
                                          'qRBfsOewa46sQLxnvV709scIwyW8TKG4x0lBjcjttk1aiHkYYMjF3IoekIAckX+Kd2g+r3Xplp9j'+
                                          'pxR2e8eZE3LMUHme6cKgkd/vQJz2xNMAiHEJWLOPegRZFo1F4n3wRnIq8AkcBL+s3NeOaRfPUdxo'+
                                          'UqSEEYw917oHmZ60XTc/iqxmadTSt01djCvPHUHHe3/1q/Nl3bpB5fB3PK2A4Y7MxmpX5PRr9NVu'+
                                          'e7mviNiQ5+PenhQMwOz9Xh7D+FRl4xPv9W8U60orGCaBZgIgrXhehRJyw7sci85Ojcq874NVDXED'+
                                          'wo5IvMeCBafoeLWMqWVWMAQr3vuQeAtzuI7XX3/Tb58V7YBnLwK47IKVu82aNQs3uEpv7Tk5Z+cV'+
                                          '4Wg75nnMzW3zF4KZOiVYhzxSpcfpo6Uwn9x6fsyqT5GhRWdeTapvmexTFt8kk45RRKGHl0bDYSF1'+
                                          'K+bRBVlGtHw15vqB9PpAi60aUI1AnJXzkuLzeAWElQ1KiXPmHUdojWoZMvW0wZWLvbOQWATbZXMf'+
                                          'YWYhvcRzZCmUhrQsGEI2JTGHTglNJyvRZjwkztUwA9/yEqeBpYbj6POaFr1UsonqSSQFXXPNDXL+'+
                                          '+VeY3r+TZrDROo5FVL2HAeg78mZGTjQClIjG+b3sT/aSE074tp6DtYVnDvBZuY5RpuEt1Di0lKPj'+
                                          'VRRlECbiXZKFAUYZkSBxp1NgNmSisp8ABuy224wXEFNPHy5iUWLVDYL1KMCghXTxwN/cumTx88IA'+
                                          'XHbZ+bP7+/uXbrftdjFso3dJShvSgDG7iOj4YrhqhBfqrxeMtsStptbfx41GyiiBGEHumu8sN1mJ'+
                                          'rhLzeQJy1i9f8P0pB8aNH1WEfQiEODmEvQCUteKmKbMLucHZlpxrP3kztiaXNx/ryuy04/OKjeQS'+
                                          'WLERpxU7CE1cNI0lqVa7Fa8zN7btNmzeYjYh6bPkLrB8SVKQGrZ43QsDZ1LjbIsdjZUXcgKoQWDn'+
                                          '3Y5ltvJnVaDQN3bHh30++ugT8pWvzC+ikbY9Dzz8cZ8ihM+rk4eGhr1lmHyOoiTZ1pRmVE488dvy'+
                                          'ypAOkI1pzUgtFyot5i2w5XeczVbEO1xrkvl7nOrklRn2PdhpFSpR7COxCK0ix33pOzJOgZgkjZUg'+
                                          'JXaJpcBGeNOqzfU3PAtRwLNjAC49b/6OO+54LCS/6VGZy1LwgkARZZWtrp7EOnjiqHRZGKRSLUqI'+
                                          'YzomakrcdFwItmkzp/XajaQwJEUhWZIspuU0ihQjLbQAWIHgQE9iBbbIm5rCaEtrMrGmz+8W5VRj'+
                                          '1EGFII7motqwUYdtYXbyYuJtMfQji7RiHT3uwy+b/jyee9Vfm+Ag+/hVbxFqupE0ZSW/ltOkKY7C'+
                                          'cmGBBbjWXoxwjHyVsBIRabVJ7CNoejmz7WE6EXgbvtGJhoWVFBrTL3zhm/L00+uiQm+dKVipE1Nc'+
                                          '74CYQBojCmNw4t4DdwEWsGD+16MICyO3yOtPi0lNBraaF6+50GyeSym97MSojFOSGQESl0HEh4gF'+
                                          'VQxrl87VAPzyrIvkjiUrjH9QwrmsZGjRSVSaquO1mwf+5rali5/zBuDSS89bOmvWbrOLhprcwbE8'+
                                          '5lhVR+l5sOWXlQESbFgZKEQqXCDD66tE4gnikXdNqS4aHxxsJjEAJvNRY93OCejE12f5hkw92wyF'+
                                          '/p+pFxVccVJxKx7C2xCJwiDV6+ORqBQ55OXpQjAIXbW4KZQrUKnE8F/BpoZOp3XDYRJjOlqr3XQp'+
                                          '8brJf3dMoBOLjECpTfoxkNKig1Ycn6WTdpRVOZFYZNONO7GRKfWuRxoJjiynBFikMjsekLs2QCwV'+
                                          'ltqVaVwSF/fE388991K58qrr1aCgvp+7PHh3V09sk6ZAKcg/8NhGDGrHe0UCFB532mnflz956V4l'+
                                          'B5HHtMBafZs+c9DKp6YKnMT+gHY7V+/OcqpSt11tKdWJz1Y1AYcEqQG+VyLXxYhnjz/+pCxYcOrE'+
                                          'SE0Mn6l6Kmi9COa0hoaGzr/19mWblSK82Q3AJZecNytckJXo+rOhiknMv+ldTdKLM/sKTT/Nl7Oi'+
                                          'NGhtlHkchIGcn96F5KCqK/DQizOUb3q9vdzqyoaSQjQzi8wsYgKKoHsILSKxZZk/F110hcgnR2Eb'+
                                          'GagABWN46gizUUot96+4mClzahKhjMFHVL8dacE0kqwwsKyHaAm0Vm50RjTVSNntaC89Uw0c5aEi'+
                                          'pPjysUwLyge9KxWAVJjUN1VZMajtRpnThAkeVqqVWAVgSjOmdG+nKYfPd/fd9ytyzmjD+gLGTHq9'+
                                          '2Y4bU8G9iqkYIQXUxh+tHrCtu6oj5g4++G3yxS98Jg77oOIxSU708GOqCmw9HxQC1cjKQRDiAnmn'+
                                          'oCCrGG2l4JfASWAKVk9vl3IdoDjMe/71r5+gY8cJBpKRiPttZcHECWoV/bzhfu7+29uXrnoOG4Bz'+
                                          'j9pmm20WYlw0a/JsTskcISf3m5xxpdqWyDkM840NV4+5fbkUaOO9uoywozet5Xx/y5/hEciwU0GG'+
                                          'UROc5CgtdsUZE68n1pPLhB9uXp4Tj/LYbQKF5gkrMX+PrECfH0B1I2XQOcFHUwLPNXkYuGYbjUCT'+
                                          'qu946U6rGgqYdiI4xdC/6TX5YkhJw71ZK2IpBAtNWakZiTn2cyeKe5R7A4xhmcbyX3koqnpID9Ob'+
                                          'rpRkcwfb5kVTcUYerx/JNT6eywVI8e/PfvYb3sbbNmVd6h/4mDLcx+GhIent6xPOU8BhkZBxP1Kf'+
                                          'VQAjc87ZP1F+f1aSYbdZBy2fYCQl/MfWBM+9rAdpWo243ti4BV7D0mp5GjP/zQrDBRdcLjfddHts'+
                                          'M2d7cLVCdqClByQljYyMLAhRwGbTDNj8BuDicxfutNMOR1HWqxidZW9NYwCVF5bVqO8XwTdn/fFi'+
                                          'MqQvGweWvuznPMpkWynK2FeIIDgx1lR4U2+/rQon8WITmohHq5SvdjS/5/uzGaYM8lGOnEpADO9h'+
                                          'dEwgI/Ox4EXOHSOg3KYX1+P462pU8UE5y4hN5m0IoGqzj6YHdR/yaaIhUYnHUX9F5CWPCrZmsMxj'+
                                          'UqOA+b4JoJgsuSHyxeY3Y2M5PzGLIndnn30SIyrxMNy642RiHb3Viq3SWVaUJKNz6BiF+wcnLJS7'+
                                          '77o3bGJnc3baqr1oJCCr7Vta0OUbvuYU6cw7IyuRmo3hMp/73KflkEPe5pqSRtop2sfLeo0khaVK'+
                                          'E4ZRYirIBq1iKCxl37PoAPhdwdMsiVLsuHePPfakzJ9/ituqXJ0WjIA4K9MMTRIB4/A5BsNzZwUj'+
                                          'sFl6BDa7Abj44l+H/H/X2cXgBOPJM8cn+l+NNF22T/q8Pwd7WFZjqY991aap3/EJMg3v4rOPRtIQ'+
                                          'RUCKAaHii1IieFTOZ01fUBwYa8dBIkTfcR62EOslJqHExcSNwyGk5TpzoWFYGAxGIRwcYkZPojYg'+
                                          'Q1Q2EXERYuE0moV4R+rVBA4JzSL41ooblMaL6QNLiXGMmJKOxkuVGUZBlBErSpQwKATeyHNnx53x'+
                                          'IFges6EbzUYxiVhB0Ho9agKQjKTj3Dylu+zyRXLeuZc6CaihrNFKtRDpQOUhc3ERplGmFJR4qtYd'+
                                          'h8rCIOz5khfLwoUnKKFIXBMA34GPIK1od1pxslTesXUwPDwUUz72JvCe4n1MurynUHByURRLB1hK'+
                                          'tvVInsOXvvRt7TbUMWKKfSWeUmVmbLzvxA7tLzj6ttuXn/6cMwD33rt04LHHnlhv+b8hnbkPgbT1'+
                                          'nSivnKIJsVXWc7dOJAsljgl0ojGwer1E0K23t0/78nERbQy4bSKyCOldioEdecy5DFwzyx1HdjlG'+
                                          'YKO7qPxTiZN6ykNBu3z0NNV8WbosesGNDcjR5lxMVAbm1CC2AEeGozPUCJzRu+iU21gN6UyQ+o6N'+
                                          'QBHooohlw0VAfKPnRf2d+SZr1Hw/69UoJMKY31JWjNeBKsJRn9GNgqn8atXbAbR2ZD6q4Wh3fEZC'+
                                          'JTIEO24M8dorVz4sCxacpgan5nLd1BmE18dUaUwjxnhxKu+qnFx4H5DD8G/qBcAY4zOeddapst22'+
                                          'M/R+I3Ua9SnMnMvAvJ/nQlTfZMLbip8gWrXUrRlZoNEAOs5jEZXn/+4hWP355S8vlNtvX+HrPrOm'+
                                          'LAUS05K8vEcBYe0NDQ0tu/2O5a98zhmAiy8+Z87AwMCi7bfbLnp/Tquhyg5DHXL8o+a6bzD2w2el'+
                                          'Tjwv2ZdKZomr/Bg4ZQ0zEsG7KJKRFhNdqRkQJ9t42Ec5KNxgDh/hxGCcDLn5PPcyO7HMCKSXZtsu'+
                                          'VX1JeCKegBAfBqvVKnJGemdSlNudYqx32xmINc+FI0jmZTWWKam313SxkQLrEFemHYtVDmPoUbU4'+
                                          'jeE4y3K8NjhXDksx/j/+nipuUNY/0DHbTiAyoo31AeCIGgWl0h8bZDjElBLhuE6f/OQXY9+FdUsa'+
                                          'ixB9+YhA8HtMT8Yn02lAGpVl8fzxWCo9Q1XoEx//O/nAn811j20agQ0fU49IgBLiKmQyVtdIkevA'+
                                          'oppORPURgXCNMiWikSuA7okq0DhuvXWZ/CoYAeNBpHHeQeJpByXHdMCqDzMNn3332+5Yvuq5ZQAu'+
                                          'OvvYHXbYYf6UqVPiW3EhYl6cLeRaLEuR/EMEn3r/LBtWvF7aImEmq3hOL6YN7wq3FP1kv38xWLNL'+
                                          'F6+JbtjEG40i2B/u8uF1D+3JRTAV36KvnxN/GIkwrFYmoySReFRmDrI0RpRXUWY3Klj81kRi0UEZ'+
                                          'QEqcqBJHhrfbRe+/g4Fk4uWeCo1opOFyZa4b2PRIJi+F6OVGHkYQ9P40xFlUNmpPUA8ir982TyHh'+
                                          'RlZcu8V/FzwJa5rhDEPOJiB9uhivZk1FVg785jdPCnnzE7ohrb8ji+kWNxS8vMmF98aBIKj/13y+'+
                                          'QOIjwnGNXvKS3eW0U79nreSO4o+7RHmZcGU6f4mLflYi+EfVZJwvnqdAqCs/UyXI+iZEvT+jAJYX'+
                                          'cYDo9O1v/zBqSxg9Ozg0qlO5EYCzoSEfHh5ZcPuS5ZscDNysBuCii84+/kUv2vk4AiiVEg5AfXuq'+
                                          '/9DKWw3dJa9K3H7T9U/dWIzHRp9EJ+y2dYIMdfX4PDvyyOBjRx4WhgEtlVje4WI0NFnipGBy/iEq'+
                                          'auXCQiHXrmASv5Wls5iLkujDEJo6hBPkwpzqynn3VrEwIwW0WV+v0YiKw5zUG70MDIAz+jTEBme+'+
                                          'U0wI4mYl28zENSn5zUGl7ZifR2aib0IcFBNlvb7McrM0oRVFN4lXkCGX6/Wox9SGnXYcx0WsghJj'+
                                          'xTjzVM477wpZtOgmN3LjVlVwj43XBRWYz9MBJRrad6lcN0L1smAIo56zzjpFdtpxh/j5YVx7urv9'+
                                          'OskEkJJpGRvC0OlnVQmTmKtFTcti4jTnQ8AQNZ1nMgyswDUi8O/Pfe6blv45v4MAb8XFReiAyBkI'+
                                          'a+ehW357x6znlgG48FeL9tjjxXMsv61GxJwenOIXmiU6E7DVbpeGc6Rxxh+JMrjxY65pr8wp12sn'+
                                          '4stUgp1+DPs5HjxyBkrafCRe8Pk6JKJd1PixEmreehwn4JZUguitOXuQJSluugaptR52Shw1ZiEn'+
                                          'SD/w1HgPlCfJTKx6uZC5Lfsk0szpuJJMqCoYG7AlrMfTUJEWXR4Jjp8JxmU+PBWLm7x9NawOjJoB'+
                                          'aEbmZp7nscffUpeCABX7BXIXAPWBojaCrRKZdKljQir11VWLZdfylGEcS5feJb/4xQWlyMUBUz2H'+
                                          'YkRXS4ejdCyH95Zw0phRwUFrMUVTP/uvx8hBB82JkRwEaauatkgURdGW7rBp+3xeQM0BZKpVDw0N'+
                                          'axTLRjGuqcQl0NkYZb4k99dMtN8A0caJJ50hK1c+opudeBU8fsWJbbjHFlEWRzACr7x9yYplzykD'+
                                          'MGv3WXOI6heDLttxozIkTsgNoBfNLU+vOvjDmWwZqbOu805acMcXCBWACMgwL+3RCKETSzkVlYMe'+
                                          'dyWhJNJM21Gtx8CZZqtdCvsKIVFKcpfJQFqJcAIODrwGvA4Hi3BxM9cm0AZAC0SYzMdm4Vys/JdF'+
                                          'o2UlLpvmU/fNytFfes0SDgkpyClssNHrTkHVpOhVwLmpsW21Yo7LEiAOa1ySmJaxZFkoMKcq8sHq'+
                                          'RztOR84VReeYM2ImCraJlIRDfZJSyeuTVUg9xsHBIfnylxe4HkDHh7b0KDpPrcfUDak2Iqk4qHl/'+
                                          '6APgHk+bNqCNRVRcOvjgt8q/fOYfYy2ejoLCKARJcZ7dPV0OXudx3ZJSzCgTKWPusxLT2AORxPtA'+
                                          'TQa+Bu77FVdcJ5dfcb1VIbJCKZjGn+QgVhvg+EZGhhfcsfTOTZoGbFYDcMXlF+Qzd94xltsYWrJs'+
                                          'ReovacEWyaWx356aadCTA+hDKipHfpMW3Gxxequ9bletFrEBMtSwAVmOYThLie2yuAOpuEbNLAgd'+
                                          'TdexzyrUK2QI3PQBpRK5AlHW26MV7YB0tSJuIHLIYzeeiCPzRTNQOXQnrZj16sTj1SYnFLVacTYA'+
                                          '5cOtr6KIWMiJKHL8wnvjIH2YoTLReeIENu6rE4VD+FkoBEpad8GH8BmLJWHQ8tBU6gAQrDNyjXj0'+
                                          'UTAQjzl2nm6I0VETVUXENK5qwTZoVaObCSPU616ubLr2hJHIYARwbpB7O/fXC+P8h9E4IdhSChhX'+
                                          'AIAQAi1GyWPd1GOJmHMNuCYBCFr1SWI5Fwc+K5wF1gaOlg8vve22ZSGyuVCvByNUcg947zgTExgL'+
                                          'AM4Ng4Orliy7c/fnjAG46soL8xe9aOcYUtnAj6ZebPFFpc05HkIbucfm+qmX8/6A6M0TV5jUiCCJ'+
                                          'lQHVoxcjYwAPwOZtc7pL1Vpwif4ztDVSToH8U0bLBnuYFDgOltnEDQpR/FgCc7punOPXMuFK67JL'+
                                          'YooRR0vnRbRCMImhNhWC6PkpOmqS6QXRh69Bj691bK8e/O7uFfLA/fdrBPHYIw/LDjvN1HPYKXzf'+
                                          'cebO8qJdd4u5O4UymQIkrpM/rqPZyy2tRWNTy6fp2mJuxXLgRAkxl+L2VIFpAXELYhDiMxOMBm7P'+
                                          'Ef97MQhV5MQTz5D77nvAjJAP1wDoiKho49CgTJ3ab9iON+iQvov7OuoYAZ0DeQFn/ORE2WWXmU7a'+
                                          'qisnwMDMhp9XK6L/TBWN8VeNHA+AyGA3EuQjlbk8M5JNaOgPKLCRTEVCTj75TKHAa+pzAjJPIyjX'+
                                          'RkNQc8HWcF12D1HAqueEAbhSDcDMWCull49gX0moIw71rBooWO5sw1ppe1mu3HyjSjhuJGwhWw2V'+
                                          '5CCdMuteKo+ADZF0iXl4MTGnrXldMWy06P2mQeDGN4nviWIeVMRRXkDL6KtWacgju6+sKVjMEEgi'+
                                          'nbRoDComCKt0dH28VGXoxJyf47nQonzu2T+XRx5+WGvbiFCazaKTjWEmZjG8ZM+95FX7v1a22W7b'+
                                          '2EvAfgGWssoz/nCQtzAewcZC5UfBzLyYNtxqFrqGuMUR7XemHZV32XrM6b/sgizTsHHeP/zhT2X5'+
                                          '8nuUoanTfAVRn5HC8O8uN7ji5VbqBGgNfeNQFBGFYUYpEOfzr//yj/KOd8yJIXa7RR5HK4KBJhgD'+
                                          'Q1CJqUvF1ZlZQlabLoZHRBEUf679bBEo00jddL7rjv3UvDjDkEaSr5t6qZwMw8zxrpD6fGrJsrs2'+
                                          '2XjxzWYAzj//rNn9/VOXbrvNNjF3xmJXHb00jRueKDY3VuYMKGvEyeJGxWLCoIa2o9VossBGQA6L'+
                                          'TYE8jIAiw28uLH0NADyZT4atVWO9VkM8NwixgQfW3cNfnnd5Ag+RbBoAthnbbMJq9FxlqqwZMgM5'+
                                          'eeEpnsESW6008JM8AGO4VSKzzx/gPP/Mx1mNyy/OPF1WPbRKm1CQ+zYdiVYyi4uQUJseffDwSHvs'+
                                          'sYe88c1vkR123Mlzz06sWLDrjco9xDrgUflvdlvmHq2UyU0Mban40/QSIkuJFC0xPkAuhV5AK1Y/'+
                                          'CIReffWNcuml15ZKlYXicFPHd1sKQDowpyQRtIRx7fESM7GA977nMPnYx44KKRpUmYvpPU3XXVQR'+
                                          'FCeJcRPiIL0ZRzFJWGLaQaJYwmEiTnRjLwBxETznmGOP8wlBSSytFntCog4mhUNgKIIBO3/p8rs3'+
                                          'WYfg5jMA5/1izoxtZiyCx4mlNb9oCmiR16810DQ2ZMTJK6XIAIvYKL7Ur5MiP/YSn1rnKtMJL+l5'+
                                          'BYF6f2qlnXbJi20qMrn/LokbMHq5dicag3JoxyYhhsUkqiBXK/Tp0liLV2aaWKOKsr4cBcdGVkq0'+
                                          '8/WtOcoWOcUnKBFWyIXlUW4Lr3XZxRfILTfdJEPDIwomjoyO6/Wkzp3pU9hnROqESAORU19vt/RN'+
                                          '6ZX99pst7zjooNLwU+PvWzksj2SWVsRaspie6CJyA06P3XIPbvMJyUNouEE1JSJ2yZV1AHjN6q6n'+
                                          'yPz6mmtuUtAMeApHd1WrXcEYDUvHyVJdOt7bqgD4wFoWTYo5gbWuLuEMB3AEXvGKl8l//Me8OHVJ'+
                                          'HC9iOXLc5drhEGj8DCQ0JSFuXPYFsKGLJDI8rrevR88Jxs24DplwwhSW2r//+8ny5FNrYnmWZejU'+
                                          'JcgV7/D5mJkbKJQzb1+yfJPt281mAE495Qdz99prr/NgAHCUZa1qXpLCh9WW3SSNOEHi4TovMENc'+
                                          '9S4dicq0Ve8YbOnk1y6nnCYxf+LrUfmXdfuyFgA266gj4Q3vLaeXsdeXCXp55eEfhaHIYt7Ox2ja'+
                                          '4KAUZwdyVgH189OsUCNSqqtLorMxhNgDsJA0m8hNsD52S01GR4blB/O/I+sHN8rgxmFdIMBZdHKN'+
                                          'RgD5hI1aNJpYujWlr1ujgR2331beeci7ZM+994phPqMp1rpZPbFqQe7pBQeLmtBnxhKlG2hiIeKE'+
                                          'rDRhw5CV8xgVUKabSsTEQfD9qqtukEsuuUbze9xjnI+G8+EzU7Kro2SwiqYEzOvZ1ciNSdQewqM4'+
                                          'Lr/sLJ8M7MIpOa6PSa4Ti2AfALEArAVrwKpFxJ9CIoxOjK+B9Z3F6kg1XjeWjjP5wQ9Olz+sfNgN'+
                                          'szlHND4lTg7TiNiVr2yYiHFcwlo9MEQBi7doA/DJT3xk0Qc/9NdzyD4j0m91aPFN6AIcjgqT8JN6'+
                                          '+U0XXicXDgvVUp4vbLs4WRxQwXSB3tT3S0RYY2kGYaWnAFgYAIWMMMK2XAPcKr5oak5UsnPL4gBI'+
                                          'TgNSBJvdfv4ZSNRhFyMltLEIGj6Yg9EIPR7ex6it1ditBuPAcmBG/oRIFB9Brn3FZZfI4kWLZN36'+
                                          'QRkeGdMIwKS9297UkkfeP4FUgn0VHU1VC9e1S6ZO6ZP+qb3y6te8Wg5829uLXgjviIw6fy1qLHZi'+
                                          'xMR0gSVHll4TD31ZeShLius1bJKmXLwmuQBRBzI1PT1wARh5lfEY8g/qPtE4j/LkBio2SnoBBIo5'+
                                          'bOTkk/9ddtv1RW6EfNird++VGalF6zdKp4hkWhG1T0o7iBETU7V2m6lMEhueABqmqTmW73//P40L'+
                                          '4CpY6qCiApUZaBLMWOGAgxgbH5u3bPk9x2+xBuDdh77zqBfvsfvCv/3I0e6B8lhKg7fFhy0Lc7aa'+
                                          'Pu+vXVhphG02kLETu/roURE+6iw3kQmkH85sM5mlLJYILS9MxByRebY4ow7vrWFeHiW0ufk3Dm6Q'+
                                          'sdERefSRh2Tmi3aVHXeaGambLPcxXBVfNKhCcBBH0cBT6AWSvmvlnUo0CAbaNWJJkrgJa/jaFKSL'+
                                          'OI9SUkCsT/7B9+S++38va9dt0M0P7w+ySqeEI7A0xYNKNGoE0DwVDCKYh30hZB2YNlX22msPOfTw'+
                                          'uSE96HN97ILLzvmGBA/zUsMRh6OAw0EmH+v6HLEO8K7tfHoDHJuRHWpHZ0LIjd+vWvWInHLqWaak'+
                                          'jMgNU328JIkIyfT88th0k/v6qVQ5PzH3ZqyxGKHhc3wnpAD77vvSKOwhivUUqs9lTUqmnvz8ZuRy'+
                                          'jVjozDSKcT0GRkEUm6HwLTn+OM4881wdIsoZmCwfauu88wISj9is7GtA9vDI8OLlK+45cEs2ACv3'+
                                          'fcU+s/78L/4sztVjJ5e2AidZ0a/fIfuuOzZB6A10+a3yEEjscZJJGNYTUyADzkKwzJs7TE/QhB8z'+
                                          'zYOr1VoMLU3cM/Ge/aJR54nHHpWbb1wsD/7+fn1dDI8kePeq/V8j7zr8CF2EnKVn1YmiOYhViJp3'+
                                          'ERoLMC+Nu7awkTyAzGXC2SFn4pO5h6eZ69p3XP3I+PtYGBDD+MrxX5J1GzbK+vCF87Re+UJzP26r'+
                                          'Tl4yQ6UFkFhZDZulJxgBRAIzpvfLHi/eXQ4+9BCZMWPbiOLTIFHFhx6dhCOcp+R5xARMItxLfzE0'+
                                          'bhVTdF0QNMqJR+CxWTiCcP8wMgwlM9KyLYWxUWz4zDXHNBo+RSk2TTVMWo1iquM6Fbgw3B/64Afk'+
                                          'gx98vxveqqZVcUBIKW1su8YAuf4wXibzboas4aKpxElMiSqJ1HHrJanFkidp1Jddtjh8LYppGeXB'+
                                          'aGDYqs5WdFYMRkZGNixbcc/0LdIAvPuwd84NN/O8l7/85fLe9x3peWJb8yECb+SoGzKeR5S86SBQ'+
                                          'YQgsZ205wMIcnWXAMiGH6QDLUngfqrQw8mAXWxG35d6xZ+85Xh+Tm6+/Vu5asUzz6ZHgMbAAAQhR'+
                                          'VRiPRTnq2E9/RnbZZdd4HpQSo6gEDitTjcc8EmAgpb9UcLLUQoxFCExCBS1Qc643NDzvOI9dSp6f'+
                                          'jLvf33+f/PDEE2VtCP8HNw7pZmAji3l82/JZDW4lnCeyr7BHO/Xw1ZRIJhLHBmpqBLqkv79PBvqn'+
                                          'yMyZO8rc975HBgamR0S9PA8wd7pvxSOZts8rNIZikdfbuLMkRkqjo9AzbNnU3lh5SP06mP4BMSN8'+
                                          'Pfzw41oKtFTKcYlwrWDAM02FWtpIhq7ATl6oR8FA1nw6E85/48bBCRTv9xx5qPzDP3wwpnOc5UCw'+
                                          'ueVVndyHmOI1EeFVKmnsIOVnpMho5mkBX5PSaNAMNN5AJ2okoLJx+eXXxZKouFPgv0ljZ8cmuQF4'+
                                          'vxD97R6igFVbogFYFLzInBfvsYe87wPvdSJEwxHuqnp0o0V6q6wvGJ2KMmr95vSO9XHLwcjvRl2f'+
                                          'vfom5Vwg9rpg2jb9xbxnEkNnKv/C2+S+6c1Sd8VW2qGhQbnovLPliccfV0AN+TTYYOOeT8d6uAuR'+
                                          'DEwfkOPmfSV4yG3UO1cjH6GYylOecEy0G0bBgMcu+3xdVRctyWNHHA+2LFNtNneNRJJ4rlt0jVxw'+
                                          'wYWyZu2GWAHgwtRwM2z4ru1DhDTVy6sefWB8V2Nj+FobzqmRxIWQOvDUC0xgaq9sM32a7L33S+Tw'+
                                          'uUdKkTa1fSG3oxYija7Zk06MAJgCROyipJ3InnmmNrTL5VkGZGGid/7CC6/WEp6qPfm8AaQ6YPVx'+
                                          'xHuMpjwSGXWuBoleQP8LzcKm7PeKfeRb3/qiRTMiikngIPbANaK9FSq4UkiFxZSOKlFKQLI0SI28'+
                                          'g48EBvE4YFiqFdhjDkENwBXXeTu5xHXEjsDUDRGxFvwN6ZrKnY+MHrj8znsWb1EG4IjD3jkrXLiV'+
                                          '02dMl/5p/XL00R+O9fZyjdZomi1DvtsWKidOKVUyjOv2RQUcSCSHx+FmYzM3vKRkqq2mqkKdAaKw'+
                                          'rBKwzTZOHHLMQXzRwgutXbNafv2rn8mjjz2h3HNozYNMg3Nstjgbj1RhY4zhZrz0pXvLl7/6tVgS'+
                                          '7HjNN87E8zoxo5NCcFO3dzQQZVpxx7USTcykFY0eS1ukveLz3rB4sZx73nny9Jp1wYCNatRgQFwI'+
                                          'FbtFenYJC6YXef0MmdI3RdOWkdHhEC1sCJtho9SDkRt9tKURATcgc1Q0wUwLkcA2M6apmu4hhx3+'+
                                          'v4X9FADpsFxZyvlB36ZoKI2nTRuy+XyueeQDP9rucW0EGTchsaNLL10kN910R7gvGz3FMOAUm6q/'+
                                          'v1+jLGJBMPq4Tk0d/OkTi8NnQqUDkVTuakl4PkqB/x4MQMtl1QvDy6YnM2g6DNUn/VBg9o+5/Vgr'+
                                          '5fkANW+sirMNvdsPMyMRQUYDECIATiAi+GdevzLB8zO1Al6VaXQzPG/FXb87fosyAMH7H9vT3T1/'+
                                          'AM0XYyPyz//y6ViGUXQ0NYCLk4G7lTvfjkooGqKnVOM1joAJcFhtt8oRXupFx/WGWJNMoe9PkC3O'+
                                          'l3cvyqk7Ntut7WXFXNatfVoZdI89/oSsXTcoG4IBGNVSWsNq6R41MHlOvcUXX729XfKXf/lX8r73'+
                                          'v1//xn52G17ajsBnwlKT4xT4bKpd4ENOiwElHQeCTE8PH4BtzqTYFpwAkXN++XO54YabZM06bOhR'+
                                          '7U9ve8PPlN2r0jcQcvlZewaP3mddaiWq7Zq1q4PBe0hGg7EbWdVm17F9xsTAJoKCO2w7XV77+tfI'+
                                          '/q95XUk7zzZ8WUmoTBgiAi5uyLjAYVBbjgEY064xoeWY6kisBOALZcArrrxeQ351CE3ImI/rLYGB'+
                                          'bHifQdW754Z1nHcSqwQwGDAAmh45joDqD47LLv1F1DGkx65Uspjro3uPGIdVhPIYmbBsCTDQSoZV'+
                                          'FwwVbxhqCceaFZ2QzWgALr7kGrkiGACCqeTF2D1IolKQzc3wKlnV2upDNHT6nXffe/SWZgA0/Afr'+
                                          'CgvgmE99Qi+gAXcUwsgjoBebTdwAUCOQ/H/TWveJqrnLQHuUQOENGIA2RzP5WCUsCgJpHP5g01Ya'+
                                          'caIvws6hkBP+8udnyCOPPibr12+UDSGP1o1UbziTLizcLJxol5GF9IJ1wvk0q1LLanoeyJlPPPkk'+
                                          '2X77HVw0YjyKdCpIWC/09yncWdbaM+WiLIJOOGclvCR5CUB0VSAXzCQQ+NOfLJRbb7tdQcCNG4d1'+
                                          '0aoq0LRUps/ql5e8+KWyw3Y7Sv/UabJucL00Wg3vbDOC0Oo1T4b8eqUMPTYirQ1lJN7aYhEdoTQ4'+
                                          'PRiSHbafIe953/tk+x13NDDLVZVaXplgg5cduVZqrM+Bk4gbhWFISJ0t/q6IuTceES1nenfttTcr'+
                                          'D4CgXJzsm1K1J4l0X9w7dCJmLgzT9IhLhVvGxx1ATrSdF8cVl5+l3zl7gbqAputf8Q6/RDezzUpI'+
                                          'YoWmmA1hnZQkg9msBmIFrdgOTEYhAc5zzrlEFl/3mzgXkBEqj4p3eUZQ2/eCTkTaOLT4rnvue8aV'+
                                          'gE1mAEL4PxBOfn1//1TnM2fy8U9+NLLjmAsbNbT4wB1v0TXr5nXnzKS1rAc+9eGeBtZZecdLcdq1'+
                                          '1xVnzXH2HjX62GmGF0pdlbfiF39w/To5+6wz5dFHH5ennl6roN9Q2PxjLimtBKSBccl6bMCHPV+8'+
                                          '7h8W1Ugm3a0+6al1y/77v0q+8KUv+eIs5g5Q2EQcQaeoBDXoVKQ0tz4HqvZovd11A1RBCKG1tzBz'+
                                          'c2U+UPXnZwQDcPsdsnbthnD+I+ppcNV6d6nJrL12lz2DATj8Te8OrjWRJ0KEc+rCU2XHvXeUaTtM'+
                                          'k9z1+O5/4B5Z+/jTMvJwq3Q3OXE5VQM3MG2KbBeigN1320Xmvu+9ESTjJrD8P5+Ad7C8p9yKmhk/'+
                                          'lsMsMqpHSTdNB2tU8M1LaslmCFAuW7r0bh8I6umBWM4M7APvCZAXWgrAQbodR8L1hzElim+SZrVI'+
                                          '5sHx63NOix6ZtF3KyHOSU+56/2TrGTms5UKvFimoQKo2slViAxArGyyBlqne+Fzz558q99+/Upu5'+
                                          '0qRA+3lQs5IgN75TM2DD4MZVd99z3zPuDNxkBgDof/iA58H7mgJQJh8++oO6Gbt7emJ7b6ddjNuu'+
                                          '1qqRlttpW74/7jLX5mFs45rYRjVq4ZuCjnkh1tx1nkC1EucFkEZb7iDM1Uh0acntgl//Qu66+x4N'+
                                          '+1FDB+iH0F9vWPgv3S6cB0LggW1CHrytg0Gi3Wfr1q+RMbSWjjSkrz4gU3r75Mtf+bLsvfdLI1Mx'+
                                          'jsfKKt5tlkS9PkRI9LaWDjX0dwhL2bRDTjm8GdVuWO8mkelXPz9T7liyVJ5avdarFlYtmPYnvfIn'+
                                          'e+8rO/bPlMPecniURvva174KzyG777+7TJnRp1HQU6ufkJUrfy8b76tPvKFko4VzmTq1L0QBU2Xb'+
                                          'GdPkbW9/q7xs333jZmVfhG1axzs61D1oFZGOh845uyFbbd/07RgFEEjEwZQQ5/7DH54p99/3h4IT'+
                                          'wn4Ka44JG6imm2s03BMcnBbNQSlIQWwSU93XQe46DaIYwD777F0iHiUR9Y/DWMI94cQfHJwpgL9R'+
                                          'Rp7DVWgceG8RCeBvSKfKkQ2+f+c7P5YHHnwohvp0GLnLpdvrVbydvBIjWRMkGQrr975nvH83pQE4'+
                                          'vren+zjtt2+baMP73n+kzJy5UwxtEkfuzXu3okwXS2mJK9IC6GCaQA+q+VcuEybBEizT10wzbzJq'+
                                          '2mCROOzDQjb8U4Uiwma96bqr5Ybrr5fHn1wTNvMGp9DWY7iYbhM2dtggu4f8eWD6DCfnFH0CAOFW'+
                                          'PfIHxQ/ag22ZJjPk0EMPkb/9u48I5amKWnjVN2+hvWc6B7WIXrPEh8XEXgJNPxxgA3kGR8PZbokb'+
                                          'hPPO+aUsW7YifI7Vsn7DkCrYwEAM7NMns/fdX9bet14+fcynfVTYuJx44gmyevUaqU6tyh77v1gN'+
                                          'wGBIDe697y4ZvHe8tPc93UksFwVq3R+MwLbbDMisXWfKez7wZ7H9lzJitmmzSAZiSqMdgB4qF6Sf'+
                                          'TgR/dZSXk2XYw1E05tj1wzSdjVrmHI+oe9U7I6EEbelRFu+fbjwFSo0QFKm4rpPQ9uYlbMxvffML'+
                                          '8tKX7mnn4vMW2RLN9UVhF4bnLCuz4oLnQg/AOkgTjTRMzCMXagnCABQS67aWvjv/FPn971fF/v+i'+
                                          'NbiYmkVdyorrUMAw6Pg2MD6bjel333P/M5oXsOkMwKEh/586ZQ4sFUJphGEf+LP3yk47z/TNncbW'+
                                          'W7YBM+ctlwTZ30/lmopvvqpzBnIHAwz0KwlWOB5g2npVr6f7kBGkDu59nn7qCTnv7LPkkceeDDnw'+
                                          'Ot04qPdTwz6pBQM0M5W99nyZkmAq1WLkODdHbnxseWDlfbJuzdPSN9wv0/sHwg39X9S9B7hmZXku'+
                                          '/K71tV2nMYCACow0pSOiVEEYRLqKBX8TsSQn7fxBYzk5RyMIanISg7GGxBysiZoY0SSKdQYVO11A'+
                                          '+szQpu+Z2e3r63/v537ud609Jn/+/A7JuLjmGmZm7/1931rv+7xPucs1Ydkey4h+9C4yF7QDXuJ7'+
                                          'mJyY9G513e9+5rW9S2XlpR06gU196yvg0nRE2cBX/+mL4dZbbguPb4iBLGYyO+J9x+JcdPBYOO64'+
                                          '54R7Vt8Xs5JDwsEHHRTuve++sGbNmhgANoXFey4Ox6081jbB9m1bwz333Bmm7+fpKCRdSbairfpE'+
                                          'XMBLly4Ke++5LJx2+qnhyKOOTgFJIJuW+xkK/y8NAFG1QYrhiC4zDkGCTPtaIIuwNMkUEelNb3qX'+
                                          'b7i+jQJp4UZcCEbH1PUvtQdJCyYKVOYvzDQGKbBoU7/3Pf8zHHnkM1Pz0YRLrDQdGDdD0GmNNYfi'+
                                          'o7gADScA3eREVKvJx7KRpgXKZHb2l/zt3/6f3qGSv2AtBUAdjiII6Z7oAMDrx/LmjLvvuW/1bhEA'+
                                          'Lr7ghVMTE+NLMGqS+u0Jzz0+POeE4/30C9YlpXRSPSH+ZJpRiHjhnHLW7S4O6jJQfSnaaIEYS7BB'+
                                          'YQuD1jYSD8DqUKP1NqxmkpHj3//tJ8LDa9eFx5/YFE//HTby6zpSzALR0l7Ya/+9wqExANRj0Dnp'+
                                          'uFPC4c84PGzbvC18+C8+FKZixtCabIW9D9ozdItOuO/+u0IRY/DykeXhpS99cTj/wosYKIZlJhC8'+
                                          'SYbTCIGMUFZmKFIblkgHXXcwCu0mJWDcT2z6mpcG7IPUwg++uzr84Ac/sM8CLMD2aWYyo/s0wp77'+
                                          '7xnu//HDYXrjTEBfpuHiGODDL33a0nDoyYeGWnxv8zMzYcu6LaG9YaHzb9X6DIsavQCMBZcvWxJW'+
                                          'HPi08OKXvSx16hkA6CEgnEbhqrpMp0tyjxSLmA1lNvpLVdqC1+ffPfTQuvDBD16X1HbwOhqhivSF'+
                                          'ezhrbse19O95rfQzwEbFCS01qLIx1wtXXfW2cPTRhydhTo1oLVD0B569EMsvPotGfeqDDDWSDvKa'+
                                          'YFNREyOVNlJPUi/gv/3WHzrxzdP9OvtMtQoaEJeMZpkF5Ol+zc/Nn3H3z+//rw8AMf0/oIb5/9Kl'+
                                          'PrJiWnTscUeHE096XkoJtenpdFuOjNQUbHoKpcBA8kw3of8K2YmRrZFwAEBVSRxUN4v+8KU4A97T'+
                                          'vXffEb5xww3hsfWbrG7eMT1rTSLN+XE19uqHgw8/LOy19762sN7wst8M05unY/6Sh5tu+l64+ac/'+
                                          'tQ7yXEzzDjpxRbj3wZ+F+fXzYVljWThw/6eGP3rX1WWdWoTEAJRlOUFLLaaWHuVFvFFXveYEIWr4'+
                                          'kS2IBpdMI3RPcNL+y5e+EO64466wcdNU2LqNhKAiL8LSwyZCv1OEe75zf/wRWSlYEn/esy94dmiM'+
                                          'xBo7ZhbteKLueGguDNocdSqAlhfn7ljYSxaNcyKw59LwovPPDfvsu1/6mpLEk6UALJosg1vXSTpD'+
                                          'O/01WmOWQIJMVai152Cf22+/J3z2s1/+hfQ5d7FRNdj6siQLIcHHERCoxjvibkAuIV4JAldf9T/C'+
                                          '4YcfkgKw0KML70CxQOhTKD8TkRnSRlwNTp30mCahiSqRDwU4lRGPPPJEDD5/wSy3USoBF+7tQGRp'+
                                          'nsalUsU2efsm3YRmZ+bOuOfe3SEAnLfy9Hh6r0IAgFVzPz7g8dHxsPc+e4dLXv7iNNcX/l8nY+LP'+
                                          'DznftJvtGULf60aNydQTENy37nUgaiE0AmUIiroWTUeMoYCyA3QTQCvARD//mY+HR2PqjwCwdeuO'+
                                          'MDs/70SQ8uRp7DUMzzrmyLDU0/+XnnlJqHUJK77xxtVhXcwenli/Pn7/VFi2/5KwbbA5TD22OSwL'+
                                          'y8O+T9kzvP43/1s4+JBDU7My82CFxYEGqUacyAIo9tFMMNsSxpz5yIopKBZvpzPvwS9L2oDIavAz'+
                                          'PvOpT4Q777zbs4BZ8t+X18LkfhMhPoqw/v6NYXbbXFj+9D3C3iv2NrSkGWLEIDbzxGzobB6kk09L'+
                                          'vlwa/DuVAcAF7Ll8STjl1JPCEUcf7eVbSM8ujQaLIhFhpG6sE9OyAwdkCVwlXIFAQ0NXj7rhhtXx'+
                                          'vv9wgfgqx2jAIMzaKc2gX7dyABvDpk7O0kTfZxT32mHLyIJEQcZr//F7/6c1AcHYY39BwXKQBE1F'+
                                          'A2dt30qbGdkLR7W1tLlLM1CZq7r8fAgpC8B12213h4989JMJ9s5RJte7eiAsmckHqJtXAButDRfE'+
                                          'jWv6jffc+8AvpQ60SwLABeetvHyk1bpm6ZKl1iUf9Asb/QAN+IbfuMweUkKZ1UtdAGYDBDmIDCEF'+
                                          'XINPOkLLABrDIimvVqWfFACE58dJwB7AwgDyw++uCt/73k3hsSc2hvUbtljq3zHNtmwBpbO+1yAc'+
                                          'd8Jzwtj4hG3OmU0zYY/6cgOhTMV62VRZwL2PvxbttyhMh61h+yPbwtL60rDfPnuFc88/P5x0ymm/'+
                                          'cIPxORvNpp9cfZOxynJ6BFBHvpe+uiTeDJJdFfoABLYQc1+lFmNzfewvrw133nVP2GY9DY4yR5bX'+
                                          'w/g+o2mMmdhtmDDE75nb2I6bX938agDY+f954o6Plc3AZ6x4ejj/oosXiH+K4Yl0O0mGuWmGMP62'+
                                          'uYfDymcsUp2rAKCyED8b1mAwBhHSb95cj+opA8LYr+5U7I5pGRYxUI3bSS/1HrpGdRI7UiNA/P7e'+
                                          '9/xheNazDkmptTa80JmpPPNAowxH0wGNdaulEGDeIZR6i2ICVpWF/umfvhH++Z+/lZyADWdSkC9R'+
                                          'q9cSLVgNQKlXZf4sEKhiMLvy5/c9cMXuEACuGB8bfefk5KRpsNEwiqCd//X2t6R0jvN7N+z0MkEg'+
                                          'kuCc6RIU5PRJG0Ux7TLmHhB+gWAW1dn2YFyQs2kMQopOyjwE6fPfffJjYV1MuxAAcFLOWkd54Ju/'+
                                          'xHjXJodhjxVLw8SiRWEI/PjUbLj9hjsMcjo5OWG9ih3T03a6PPWIfcPIsvjeNgzCstElYZ+YAVx4'+
                                          '0YXhxFOenyTD5ImHRcgucZ4wADK30KbnfaJdtkZSEshEBx2fo+8BgEGlnpR+ESDefdW74+fbYLBg'+
                                          'yw7QxGrEDbA01pRj1Ju3dHk+BpSp+H09NSpdwjp1/zMPCCWdGH83NjpiWQDgwWgGvuL/upQ6hVmp'+
                                          '8Fuq/lYdjiT8OUy6DEQAluVC0tWv0GLx/29763tcVbhHBqDpCwy9gTg0fL/steVZmKTHa6X6snoD'+
                                          'CLgaAaKhiCbgs551sB0wTUedokShjLuLqWSENud5SF15+SQQ9NN32Hoj1filM3Kepj9Z5aS57rrP'+
                                          'hx/88BYfU+euAEHHarEJVfLknkmqd6aMoT3fvvLe+x/cDQLAuSu/OD4+djEccyUbhQ++LZ6Sr7ns'+
                                          'VWG//fY1xZaW039rbu/U8NQqEXS8ARZ8sdAeqZH0/lnX1RfotmPmK/y8lIApBsG6Cafu7bf8OKz6'+
                                          '1rfCI49tCOs3bja4r1LAnW8HCDQjT83DeEx1myM8PW//xp1hdsts8v6zhzzeCIeevCJ0wTHfyk0B'+
                                          'cYk/fPs7fMTXTw0h0lJHUo8DnwNNLSETWQvXHK4sLcEiLQr0AAy8ElNQyk21HWpc883ftU74A/c/'+
                                          'ED78oY8SzhyzgK5DqIN3ssuPW04ohHIuu/7VBmB5fyjE0QyTCABLF4flsQy44KLzw/K99krZAzUI'+
                                          'JZQyTGrCgkOX3IdBosTqNUuNyHLacvfd94dPfvIfEu8eM3USebrpdETgw72Cc9MszGHzWiIf4dmj'+
                                          'JKVc2IB6krnMU2gZjhLgiCMOWwDQUuBSqSBHZgZk4fw5cpS/hAKYxnXVAGClrntGSGDmiiuuMe5J'+
                                          '6dRcJERg7tOypjMDpWatcbpeIwawK++7/6H/+gBw/rlnrVq8aPJ0LPya67fj/+Haeu65Z4dnP+c4'+
                                          'V11Vx7ueUtKkDiRMvJ8A6ohKHQjrIomJ2EPup1Fg7m4srCt7CfjjU7bw5S98Ntx1171W+wv0IzBJ'+
                                          '2ggVhldtsghj+4yEkbGx0MAGjV/62M8fD9s3bLevaI42wtOP3De+Vie0H+uH8fqYdcff8ra3GhhI'+
                                          'LsbSlzOQElhp8fMz5R8mGXClr2LA4UIKLUdjaukN3X+AtGQQery14Dr43YSSuymWOZ/7/BfM1x5B'+
                                          'YDCUSUV1Q2eVzV7KhYkEky5vBWhMiwWpDGD5HovCmSvPCvsfsH+lI99NwUP0WN1go0KnWrrtmIEi'+
                                          'LBx7ll58+H6QgL7znR/aZgIRDGAcyMmB5msZgHH+u7ahQXYCWUhGrThshkWR/Pxg443DIomHxlMa'+
                                          'Ex1kAEcccai9Lx1ckmTX/6vxp0AlnQfdV/UxwMUAZkJrqko9lrW8qOGve/2bE3+llLbnM8EewPOX'+
                                          'oIwhAL1JjO9BiYG1Pj0zfeX99z+8mwSAycnTa075pWtqbp3Qo489IlxwwYvSyR9cptpOU4+a5s0+'+
                                          'oE+gSDoqzKl847NTW5C566WL3BJS88TUfgpZRPft523asMHIPmvWPRGe2BBPfwhntLuBLDWu8ir8'+
                                          'UldtaRFGl7diFjCSsAD21TZeRAMt1p9PxFOh3TDq7HnnvjBc9rrXOWWUzDdNM7igWYvi5GffIasA'+
                                          'pMpOb88Zc6QG922zsNwhIAibrG3GHcOEtJNgqMl6x9//+tq/Drfd9rO4IebohjMsnWrKADAMO4/7'+
                                          'tJjLkVz59zyR6mFyYtQmAcuWToZTTjs5HAL0Y1YKg4ofX9bKpbGKyhpAfwkdZve/KrslcVhc11zz'+
                                          'N2HLlq2phEK6j5+FKQyotegHiNkpDQCgKbH2gENBGYSDp+7Sb2i8UiuQqTS0Aa+66q3hmKOf5Rs8'+
                                          'T2UJ3qM68pI4E8grz0q0YAKahVIVSP829Ia2LNFljwd9g6uu/ouk9qQDIPcbX3djV/a1QqK7Kyqb'+
                                          'LV4NAWDmyvsf2A0CQCwBpiYnx5fgA7MDTxxA2yCQY+F3f+83efL7h+j3Sl34RpOIOCnGGDzYEYHD'+
                                          'IiSBhcwbepnLfaXl7AFAqZ0EP/jvWbjr9lvD6m9/K6wD8GfT1rBtx4xNCLJcMllZ6mL/ws1pxU21'+
                                          'JL6nSS4uXEhxu9vir63xpw8porEkbogPfOD9Yfmey73xSGBMw2WiUetD7LHhGQB1EYZeCnCSEVwy'+
                                          'vdvtJLcemnUUjrSj/Lelm4FQVvQDpB9IIVM2SzHxeN+f/XlYv2GTNQS7nZ6Lqy5M81NN6gShUNn4'+
                                          'C0sGzrwxfuIkYMKgwaeedoqJiEq+S4GianFugqju1yAwTSm37gtePZ5KgALy78/f9zFrjimtxyku'+
                                          'XoUQiDWHWhMc1LC0Hvca9xIHkchn6sxTGp0pPeC0V70rBoBjDl+gBERXZG7akFEyTaPcqkxYGdyr'+
                                          'itE9RwbO80BL0OhhyoC+d9NPwsc//ve+9rK0liVhX0uOWfV0QKgBiFJPIKGYCV15/4Nr/usDwMUX'+
                                          'vLCAZn/PDTLNPdZNLzCa+a3feb3hqOt+Qrl+r90YWTIVng7Kprvki/cSwIe0yDzNZWUQyTFJPaH/'+
                                          'sHopEdUP37zhn8MtN98aHn1io+H+lf5r4+j01fVvZQVZw+WhOiH9G74XM+Zzzjk7vOE3Xu81P1N+'+
                                          'wFZN8NQaky2HJwfnFJQ4bzWRyveRJaQXalrUm20T+ugZgcZm3/FzxugfCDByR9/K5sO9f2TtI+Ha'+
                                          'az9mpcCsaxuUGHqd/Fp81dS/RAPya/m7aQe2GhbQl5hOwKJw8iknxQBwaELDlYrL9Cyg2Wvf3YGy'+
                                          'UAp/lqInanCpUazm3qpV3w/f/tZNtvHHYylmp70r7VqQdPFWbGZzMvLJkk7aoUO2aw6AwrMQOAf3'+
                                          'HdkEAtJ73vOH4cgjDgvqi8ioBBkEnmHNp1D8XG5fLv6KB4DS5q2X9AGCqxcXRUiZjwLe3332S+Fb'+
                                          '37zJ+0GlOajKYpV3UgcqA2UtEeXwV3Pz81c+sDsEgIvOP7uAo45tnQIfvGZ1LiPyjnDhxecaJFX1'+
                                          'jAAN6gsMnIs9dD2/6jyUyrZDb/yFNPOVFbXSvyTqkGUp6uJ1Pv5XHwkPrXk0rN+4xZB/7AaHpMDD'+
                                          'TV/4YmT/QalY9e5UT0U+fApETMQN8eEPfyCe/nsG8t9LI9O6q/CwQzziiz2zINDwf+OkIEv1Zam5'+
                                          'j+lB16XK2s6a898x4orBYNDvp9qymoaLBfn9m34QvvqVr4XpeHJChstSYqWyafJR2fj6/2JBJyDV'+
                                          '/whGkxNjlgGAGASNgEOf+SzCff05sQFG2yw1FqsegDq5NcGo+jJa8Pcg8u6rP2SoxX78njGnl1N3'+
                                          'sG/9BOk4qnEIOjRqY/WL8HUIlMGx+BzBlT4OLK2K+DpvC4c982A2nOs1J2TVvPHXKfkqg2EF3MQe'+
                                          'gsZ6ykg6nW66Dy2XItMlODCuK698f3jk0SeS+nDwz9/w10pQdzkF5y7Z1mwGuVxZFthuX/ngQ7tN'+
                                          'ABjlYvZN1J5ve6e7E4448pnh7HPOtNFeskjKJEWlpl+eCEHGgQ/lejQL7LwMANaEcc17fJ+p0HqH'+
                                          'F1/bctGIudnp8NlPfzLW/4+HTZuBlJtOQhvihf+rAWCn01+pcFEJGoXr0D/3uceHd17xjgVeAZI+'+
                                          'p5sxa8JWDAA116bD4kUQIKilmfAKsjkn9TRPKTMAKAOTvqbHPcQwkOh0O+2UelO2yseIoZTf+tzf'+
                                          'fc589QgT7jpuvRzHJaEF3e9fKAMwhiUDDcrBi2IAWBwDAIRDzz7nhWHpsj3c2KOojFXTnUuIP26C'+
                                          'Xul461lIdeSnX2tiwDb4b5N1vBpnuE9o3KkpJnYh1stcTPdFCOIYuEjwYzkHK8QhI4FoCL4XPYBn'+
                                          'PfMQH7ORZYp1is9a3tvM5/vNRO4R41WXgnc1m9PoT5Jy6m2gAZhX5vzBgVHi/xde+paZpiNlm800'+
                                          'ncDPnp2ZvfLBh9fuJgFgdNSdeajWikYNTEHm4LIaP/h/v/y3nOtfT5uEwJ+h+6Dx9KasVm41cU2G'+
                                          'k75G6xqLFEWa+5OYERxmSrIMyT994/z/XQwArP+njKRE7YBy0amU4I0um2LVYFD9Xf+GC5iEN7/5'+
                                          '8nDKqSfbAkEQTNZXQbgGcrknJiZtcaBHQupywwVC6mkMJNVkzKc1SpP+AE7RrpcAyABi/kSZ7EE/'+
                                          '+QT2XZTT5LAMyJKbQMYn/s/Hw6ZNW+zzA5uBbjXBR8MF6X85EfHQnJXNP6T/SIsXL5qIz5WQ4HMv'+
                                          'ON+et6yv1NgsdQIHqdcgvz/BmfVaQmJK+gq//v7v/yXccsuddoCgTleaTUBPO+EUum7KqoMA6wF9'+
                                          'JwV49kQoHW4W8K7KhI8ILIcFgHe9JRx99LMqgV7eByE1+Ahuaic6cBUvwQNkmBCKYgiWY09ZqBHd'+
                                          '9/OfPxj+5H9/pCKLX0vALmazPOHB9RCJTpJheAZ1Zyji9xjErnxodwgAF57HDEBKvCBmYCMAOLNt'+
                                          '23a7cee86KxwwIEH8EGHkt008Hm36jaJftTcGFFNPTTuDGHlN0NUzaEzCnHSygJKf/+z228NX7vh'+
                                          'a+GJ9ZvDpi1TVv+z1vzlLkk2L1++LHz8Ex+zv5PegSyylN4N3NYMDrYIEggEBpixIFZP9aIYanIn'+
                                          'Vmo8axz3AeW+TTOwb70AlAXYdAgQREPGxefNTWyCek3pZxGmtm4NX/7il8KGTVtNKFPlAFLZgSPv'+
                                          'kq6+LwrNo/GZWg0YiFB0Y3KSWoH77btPWPmic+wzkTjTTWUbT/wS0KQ6WPRhCaYKD6IxmrQF3vH2'+
                                          'P7PDhCSftrnmUKKrmUqerst/I5sxoJjrJ+JzSX1ZG1+UYDAx0TvR6zADeIshAalQVUvKw8I1KPtQ'+
                                          'WVYUMpktEpxdqb4gxJI2U1AhYIiB/vovfS384z9+tVIeyBBH0N88AYLYAygzJXNEcvVpszufnrny'+
                                          'oTXrdpcAwPEW/NCgdqsHAr49AsHBB68IK88+w0U6JI1UT6M7LYya+/xZjdcnkAX/L863SWJ7o09u'+
                                          'OXh42AAyg5Ce+s0//nG44as3WP2PBqBov7pSJ9wRh8qGi3/n8+bWvW+EF52zMvzGb74hIeBUx6uf'+
                                          'oT4EGjfokZh9lSPM2CRqLmCY8aSoJ00DM/7stn3WP2+nv2UAIAcBzVYQJYiv0Wgqy7PkuCO4Kq5H'+
                                          '1q0N3/r6N21DgSAzZ+WAW4h5iqrNKqSZCVHYrxgARltUC47PFwIhwHYcsOIZqfkm+rI2NH8Ja5Gl'+
                                          'sWbd1Y2qI1C9Jh7FN77xnbDq2z8IuZuODobEEmg0KkVfbHQ0YCGHPjkxYZgTNAtV++MOy1ZN3hBg'+
                                          'lCIzlRtz6gEc9gy/9wwAvR4IOmSbCtaLS45LWI9CaXLkmbvoSpbuh4LBzvN/+AHeddd9Ce8vtKsk'+
                                          'v1WFaUqmMgLNTybG8bVqlNafiSXAw7tLAECX1RZ+QRUZjVyATYd4JiLy7/7ebzBdBdbfO6dGvazU'+
                                          'zKzRGI2NWtob0Fvdefg2Mx06VTi4rFgh265Bkv/GP95x6y0xAHzNDBi3TO2wADAYlOqX/+pIrHLt'+
                                          'nOrpwkKZiO/pyne9Ixx62GGp9hWSjExA0UMbliaTpDJqmY3ZjaMRCLBPf5D0BiRIqboYF07Ttrn9'+
                                          'di3AQU8fKjhEBLIkgGpQQrl5Wix/AqWlWFBrHnoo/ORHPzR8AFJa4CFM/7DHkmEwLN1rMg/QdQ8A'+
                                          'MBJttuph0cR42GOPpeHk006zz1IaerDDL8BMlskyzCHWtdIhWs1Ambho+oFT+T3v/qCNb/G6yH5G'+
                                          'RsbjZ++4uzBh4XPewMP/I9vB5Gnb9m2BVPReyhrRh6q7pqLQpiwhSNdVBnDUkc9Mz5tNwnJaopGs'+
                                          'yhOCekoRV9X8EhRVT4LPrkiaBGoAov7HLem7L0ZVZ8LKYA8eBpGvlXgAwYCDawfgEJ2bn33xmjWP'+
                                          'XP9fHgAuOG+l9QCq7qfsBNeMuoqHjpHMOeeuNNupWiIAuYy0031zr90zXzDABAxk2uD68aihO064'+
                                          '6PpGkj87UVVUG8KGuOuOOywDQAkArX+cftUA8P/nyt1dd8UB+8da7j2WcYgLr8WtSYJmxA2TSavb'+
                                          'ySEMQGuEUwEs+oZ7wGnDCo6qpiO64exsd+wUVQBAYOh25ymM4pwBqejoRNfiyn1Ssnnj+nDnbbeF'+
                                          'qant9r4hg4bOuYmguj+BFoYkqk0hOAaAlv9+xNFHhac+/YA07tN7p0pwOzW7BJ/VyZhXZuLGCfGA'+
                                          'p02watUPwje/+d202TCqQ9qOTS5pN246WY53EjZ/+47t6WttOlIrXaF0DxSciE/oWoC64p1vCsce'+
                                          'e0Sq/6VirYOhKEqvAz5/+f4NErZAn0EwZ6kBiSwkc49bbvmZ+QHK508nvP08s75j34sHYrHAJKQ0'+
                                          'di2nJjELPGPN2kdX/9cHgHNXegngKXRGJRhiAjgjxgd+2tP2Cy+55MJQ+cIgsYxCyjh+eiva5y4f'+
                                          'VnPcu4gdyDjonsMAgB6BNU5ClgLGA/fdGz7/2c9b7YtMZM4tvhae+NXKN1T+7l+/NUTDjYULLzwv'+
                                          'XPzii2g/7imw5M7r9XqiAnPE2bRAJaSkxoEtF0tNNWSWpVcWIpBKNsS+w6cQ9xUd7+HA3GHCbAwG'+
                                          'xh8QKtCzKAQM9UfsZ1vTtEdxjPhzbr/lp9ZRx4bFhsJJ1nW0XolTIBGF9X/LNjagv4cfdXQyuxgM'+
                                          'KrTZBkdhTefEa/zGrn/ptmPUaFcPUrqMr/3TP7uWG8Yh3R0LIFQSAqW35zx+1ek4zSnlNbR7ApPX'+
                                          'YTrF+07SGaRxGjIm8FXQpLbvmZsLV17xB0YHDk4xrwaArr8+JcFLog8u8jiaKWvYmQ1YpTcraMDg'+
                                          'FPLmuEqzVB4qCnC1PE/lgUoerdVy8sAyL66R3ScAsARoWH1JC2d3oikyG1cpbXrt619tNWSq3ZsO'+
                                          'dsgpijh0IQ+sYrkEVVl+3NwLNd40ERgIWmmfLA8b1z8ervub/2MTgCnX+0/SXxWkm1JG2/qVvsBO'+
                                          'My17aGDEYQ7+rquvDMv32COFD9FHdRIqC6g501F0YMzfG86KJCU4q0xCSPFlOsnNBRCL6c3HxY5a'+
                                          'n1j2fgoAkDZnAOymdDURslwOS+Ca9ND9xH780XVh7UMP2ulvdlMuK+6DaKooG9OuZvXz0w88MDz9'+
                                          'gAMSRr583brbsZciL2VfICRuvTam1kKZGeTmkff979/MwAgBj/m2PWespV78vCPNEQNGYXPhnojW'+
                                          'a5Bg83Ho2Hu0UWqd3X5lACU/v7CvYQZFtObVV701HHbYQQSaVeb2uNiYFZCoVY54QzCeBQ69dGT4'+
                                          'YsKEBePCnjtGa5KC681vvtpMXNT0lOioUIIUB60ltqOYsuox1Ux1mI1B8CLiN56xZt1uEADOP/cs'+
                                          'KwGgzro91mJY6BNAbxlmvWyI4AMdeujB4cKLzklSSupWSydPfuvqgjJQDK27j9Tf2HPF0Dn/wzRD'+
                                          'bbiISCMZjOSWCr7/fe+zJiAYcrOzbRpF+jlbxcHvjH/PFvwDPwPGYDj9jz32qPBbv/PbpdOQw1g1'+
                                          'n8Vls+ecZhWo13IvAQznYECghluN11KTSO+n7nbWtCxnCgl4L0oAcQBADDJzzPYcdQO9Ltapo2kE'+
                                          'TjEsep2M6pvoueBrESi3bNoUZqbpnaesAZJoeyxfHsYnJuLve/E+YyMH9mM0LuNm6S5IT6ssP4FZ'+
                                          'xP9vtbRBeLpBqPSjH/10ovDSQ6HnDePc0nqIfKCDLz09bHop98pGnTiU3Ob8hPPWbFrSdLg5AiMy'+
                                          'gNnZGXt9vDdkABgDSuO/tDwfpOfZdWr1woZgL2UfVSlzWZgXRVgQAID//6M/+jMfffeTVJlUkTKd'+
                                          '/h4A2OPKkjyYgql6MkBGrl336C+9f3dhABixRY4xUwspb2uEpCCdFvGOzM3O2+n1xjf9tunUCdiT'+
                                          'xEFcx03ZQMMdXy0ANFupUSILcDYE2UXFaSqQh4kouIzydX/zN+Huu+9N4p8dn5H/wo3YCfuuhovm'+
                                          '4dj86IIvWbwo/Nqvvzo8+znPTpmEKJ9CjZn0VJuGFTjNYHCSu6OteRy2Rpz+zKlH3VGO6tjXXO6K'+
                                          '7roDH/Vxsw/N7ooMQSx6jATx91b/e/qq09egsfHvW02pDrH+ZTlV4hkUxAyW7ad0teblqM/xEDV6'+
                                          'Kaqmll+gAqC+T70InaIyDpVEWKltF5/Rdf9goh+z0Ph3+Ky4A4E6GclFOPcMAfgApd01h4GboAay'+
                                          'IDg6Q5gUFmLdjt1vqgC3TRW602EmiKzhj95xudGBVWOHUGYMVSvvKpJPduis+0lokrOQoQEHvJfV'+
                                          '5vHf/t314Rtf/673MQaJ529emc1GhZfBzFOoQGJQQgqicg/Ce1/3yGO7SQB40VlWAqh2UbPFQCwD'+
                                          'KsSoS48NfdJJJ4SVZ5/uKXzNN3ZemQnXEmUW79AccQd0VM0TFThYwBm60wxOCOPOd9h0bHitdvNP'+
                                          'fhqu/+KXLAMADmC+3U0zXcGupENYBgH5DpbIQ3y+xbF0WbFi//DfL//91FhTABASUBt44Kg8a/Y5'+
                                          '8CcE3h/0Rmqe2tVdIQnfTz2FftBIUWhA/BmbHScYce+sbQEEmpub8Zq2v4CEYxLZFgREiyLLjMEv'+
                                          'S1pzeV6rwHK54DQ+ZKYwTBh4TlgGC+S5Sh2/UthDmyTL8go2PiRAj7Tz8L033vijcOPqH9j9wKbG'+
                                          'uFSWXrg4+CkggJlYc8hogDUJPnFpuj1Ys9FKgiEyhe10OylAFzZSpmgtNir+DgHgmc88JMmCp6bc'+
                                          'oGQC6rRXwCNJK6SGrRCANbdv5ySgviAAvPktV4fNm6fSvZLOpRCEtXpJNstcC0DvRSKndR8J4j3F'+
                                          'smTbI48+/ktbhO+SAHDei860EgAXoi1urDr0sGS2RxEX0ujYqHEDlixZEi577avCxMSYb4oszcyT'+
                                          'NXjBsZL03yV6ARCRbL9S4ybefMyEg58UhcuADSzKt8OHP/AhioDCQXe+w1mxZMk8CxnuNArUjUZD'+
                                          'C7UezDLBg3/Vq18VVjzjoDSeSZZeGv+FIukaWgSPPx/NKRI9GL2tlospPz3nQ3ofOhEVCBmQ+HmQ'+
                                          'thpKDWSgYmDqQAgE0MUXS1BmpKYd4IGEtlWDxLwkPbaRAh8zhvIz68TGpkuyXhkNWcVSw1XV/teJ'+
                                          'lvT8KhBavYfkD1khDm3dui18+COfpBqWvz42FZiA2iRqkglwZI6/NbIzMQWRYxMCAhqFbZdQR0mF'+
                                          'wIvxYO4MUm42sgc1BUAJcOhhB1mGV+ViSLlJn0ukrUZl6qOeQBURWIq8lv2EdeseC3/0zvc5lqFM'+
                                          '96s9EClgy9Cm2SAysEoFFgKwZloAM6sffeyJM3ajADDiaWzduMqq2zZv2WxEGINCxlQYDwQn3dOf'+
                                          'tm94xaUvWSDCIFUfXCI9iOqrjTBwuCzARjjlG+5Nz+4px1bSIJRL0C033xy++IUv0QCk3fE0jTz6'+
                                          'tFalOZyV5gx42JLBWhJLlsOPeFZ42Stfmd6fFnq17gUslYCXhrMbqYQ0MjJmixz3JATfjBUyDIKD'+
                                          'vPJq3gvR+5LoBzr93V7bsezT9jpdP/3bnfkkGNpPJKFB2vxVNaARd87JslJTQQu6KLKUjaX61MFF'+
                                          'gkJrji5EnL6uDKolPVZS2LiX0sQfeDr/iU98IWzYsDGRuXBv2nFzTsdDoukd9lRm1RqGGEUGhKuq'+
                                          '9iP3n8wp6ILVYuPPxMBpSjuePkusEz8XU4Df/Z3XhNNOe17qLVQVrAWXJoW4ngJCGQhIStL3KXBL'+
                                          'DlzXZz4T0/9vfqdiPRaS34UCr55F5s1X+xpzugqpYcrykdyRmC1dHwPAi3ePAHDOmVYC4MZAmqnn'+
                                          '0ta4yabSAiw87JO6YGHNOpCnFi591UvC0/d/ajq1zcbbiSrACgjTrZNHp6SMH8UKlO+f6nWNEqnE'+
                                          'w5Hgl7/05fDdG28Kc21F/0HyGdDsO3cBSz1wBBrMvaGEu9eey8KrX3NZWLR4sb+XIjWASnuzImni'+
                                          'q6ln/xbf/3isPYOn/NbYqdEVBxmTTCh4yvR8SsB0u2unOWHCXWcFQgcAZZVlAcWAHgLGFuTv2ugD'+
                                          '9/8TX0LqNhK9LO28a7QbS669WXK/1TiQePdhSpNLanFYsOE1ilS6r8BQd80+bTRIfa9d81jauF0w'+
                                          '7GKJZzByVziqptZYD10fsaIrr/IkSY0XA7cEHyYfCJl4SiNSUGGNbKEd8NKXnBsuvfSiyucN6fuq'+
                                          'UGULOo36gl6AfP/E/5f6b/U54oL+PwFIecqWEAAGfvjVTNymlAQXlL3mcmCs/bV2GJzn5ueufOyx'+
                                          'J67YLQLAuS98gXEBMJdfGtN7wC1hhYROLU/n8mQm+YZMvtZoM7zhDa+2Go4PmQAIe0BNOQDLYIIK'+
                                          'Prgn+rrMzUEUOBSdxRZseJ0tnYCvf/2b4Ws3fMMWAYBKCgBV8oYcYUfi6+Mz4PR/ylP2DBe/5JKw'+
                                          'zMd+egh4MEqZTb7bF6hqQMGeC1NxGXFUIH+hYWUb3bUPuj11jwsf9TAAGGY9FK47P7Cmn9X4DgcG'+
                                          'RRi/EExQJ5djyIFTWNmLkBIvy5DMZbeZojfdoxGX6l3dS2Zg5XivyvuXNp9EL9W0IkAoTxtJabJG'+
                                          'ZDd8dXW45Za7aBhiCr9U7GF3u5OCsWEf5kv5MOkpQngWl6jlQPxJDi7LCTqrcrelNaDPKNk4vOYl'+
                                          'l5wfXvHy8+1Z4LWqopulNVew0hHvXVmMMpOeW9zhM0vxh/eGf/7ud38c/uqv/zb1W2Qfn3nZmTa9'+
                                          'Z2KSdsN919i7ahLKoGvv/Y2PPb7+l5IE32UB4IVnPd9swUR1RV0KWW1EctAuWZvNc+6Nk60/tAWP'+
                                          'SH7iSceHlStPTxLSNa+LtclDVoqHyDfezB/NlpqwYyHMcA2dpssSxEdrWZ461+Am3PyTm8OPfvST'+
                                          'sGnT5jSBoCNL5qo9DXPCweY/4ID9w9nnnGObX6wvzrFLCWtpxOGXUkL/kTzFugPrf+DUNz8AM4Pg'+
                                          'SUjPw8KCo5pKBEc1XBKsY6AeNLNQF4LFhvq8MG58x1CCxbBvm0lmImziZcmrXouGqW9JS0Wj1dh+'+
                                          'zXr6mr7DmEnRyKzxqtQel9R81QCU681wWMpeCz2nU78sFYbGhgPbDz0jQH3RC0FTFF174zY4RHzo'+
                                          'HADLgLxcaTZkyDkfSKDqJgk6/JzCobdDJ2CRLDRI92GQuCbUBcTzesUrLgwve9n5ljUAJ1KvCG8q'+
                                          'C6hCgw3g5lMVibkq7dfmrwKGrn73B8z/r8qAtDWelRqMkv6ynz8kuanqEiTQkJWODjmOgfiMGABW'+
                                          '7zYBYGJi/HRBWjGvhSc9HhC671j87fiQFk1Ohi7SwkAqJxY3buYrL4WJ6FNcAryRbrY9tKEygKFD'+
                                          'jYepocQN1Eh/Z7BMJwOxK9zkYnSDjcQ1GBL08dBDD4ef3XlXeOyxx8LDD61JdMvFsd5f8YwV4ZBD'+
                                          'D4l1/5EJI1A2ycqAI+y35t1aOJq7k+ONEmCCAQsBxqcAbIqVwYQ9jFplvk0qKzKmUgp6nkaVtWDN'+
                                          'LDjighpMZ1xCWVUycDIwSEi2gY9Iq4ITdiLh5AolCKoqYy18e/nzyhJAxB5OMgY++84rnyevIOPi'+
                                          '5r/nwXD99TfYJkc63nNpbZFgMAZEOYeAZ74OUP/pdZK2nqC1CrwSBNHERcQalAJGB3ZFaWQItXoJ'+
                                          'BpJzMH4GAsClr7wo2ZxrTenrJFfG2p0ZEDKAqpKx0JC6FADWrn0svP0d/ztNiwQW44QpW5B5CqOR'+
                                          'uxuwhtA44FQq0COj4QzR4sDHHt+wZrcIAGefeRqNQU3kom+pFCXAqV03Guvo9jz1AfGQiedv2wKQ'+
                                          'kvDv/O7r4t+PJB69hBsxt6/7oipT2SyxtyxIGLa+ZRF+WAjRlaXadzAsdQhEQZbggpxiqzJkA9/c'+
                                          'Nr4qCOXVZlfzTHWtFqMWm8FdfdOofh0dHffuP9mPmEWrBOg7dwLvU34HSRasoOqt2GLUvstS7Y9/'+
                                          'm5uftWwA40BcdtplggCXkFhuzLJbnSCouZRn66lJpZ6GHH2rzT+NCBei/bJkrZUIK14C6N5C4vsr'+
                                          '/7KKp76LgCJYM8Cx6w3quHdvLUCK0yHmJN1wZtMzVlYoWzJcyMAg9qm+UOH3RGm0AhXWJYLAy+Pp'+
                                          'f2k8gPj3fGboZ+k5m6Rb07kVReH29vWEbsQl+TcFPZ30SP2/+90fpQCQMqOalKJKEBCVgUl2s0PB'+
                                          'UZzVpiGl72hq+vgTG3bJ3t2lAQAPidZLrGkFBuKMnuM2G9cAjQVNu4x+gN14s5+y1/Lw2te/ymWu'+
                                          '8kQWQf0u+zCdxByfFQuiv+akkoQKoQSFyHoszxbyrdNpAIqn6/OnZpB3csncYwAojS7KTTBIc3Fv'+
                                          'HLnOgYQ5LMW2kVTNPQwKm3WzPGBQaspHAAo4HSoWNz2YMhtgbU0N/IGXM0NmADEADKwB2ClVgp1w'+
                                          'o5k7y6uQGqwqmUpFWyHZeN904gtTINCPTmBcwsar2Zc2iTcLpfykzf/tb33fNj/LpFFbFy0cBPPt'+
                                          'tDZQtmnch+8H3JXzdGIS8Cy7Zo5K2K/cdmk7VksiM/ZnV4eSxFcVdivRDmykSy45L7zskgus1FG5'+
                                          'onujtVANAEJSQp8AGWPw10PTl5R19hk2b94a3vimd/nzq6dnWA0A1b4B5cA1DWPwovs1sTJVmHl8'+
                                          'vdueWL/x2N0qAKAEMN9yw5MPjMZbjkpG3Y+un3j9HedW8+SmDNORRx0WXnjOC3zxue98lrk0VM9m'+
                                          'teXojcwolBJWG7qqikA5shQf+HgGn1RNweDNm8ynBggIpe1SXopWVk96t5cWAUQPDY0tLARBnUMQ'+
                                          'yCMk6TNiuEe84UVijWki8LCzkRdRbt4I9Z8hXwCNArmh+6x9bRHO28bH9+L/sRA5/uuljShZLinm'+
                                          'aARWTUvRAxD6r8yssiRGUSVPqVMuUhbHeoMy6PVEQ2YA+OpXVoV7730oYTx6fjBMTW11x9/MSgLp'+
                                          '4g+MmdjzAF630SeeDT6bMhkhD5EuEwMw4ydmUekbUUEKuBOczl1XqsbPEWMPAQkZABqBymBkY17y'+
                                          '8BfO+Ok+JLuu3A+Gvpeg/dRP+ctrP23cBomIpg3n5Vfu5Vf1dRQ8pJERHAxG/YyScBQ/y/XrN2z8'+
                                          'pUeAuywArDzztGvGRkcub7VG2RBy2y4ZNNZ9fGLcbHO/4UIxVt9Yyx96334/a+Vp4bnPPa6si3ws'+
                                          'Z7P9EFJzRNBh8AFk6cSF2WRH3VmBSbPdRUOVotE9hj9fWYEINAu08rOQmlkCZeQVjDvDhzbLMHVz'+
                                          '7TX9a5CW1pwFCFAQraAbqWsukAledtSbiDzJ2txcGfUC1WxCE0z9ADX/er22paJmLOpqN8xQemzq'+
                                          '1fKULVXn9uUilzaCGn+lDJo0/TJnecqvnidmM/17Ke9Nuuz11389PPjAw4RBe2Dru1EsxsNNL636'+
                                          'Q06FbLP4BqC6ExV/KePdsdc1XL5vdMmNUx2IupDIcjCNAn4jGINy3h6T8UhGRuzUzxzdCcDRK2P9'+
                                          '/8pXXJielzK5quqPPo9wBDqApIUAlCoOgdnZeZsc4fT/X2//02REKls0/W6ZqPdUqmpCuT8LMUKz'+
                                          'nPRg6UVkHszje7gyBoArdqcAcEWMsu9Et19KLZqTD5A+9piiEoDCSIoHg0UNlpUsngd+yl508QvD'+
                                          'EUc8M52+Urqx1DeINJGnzaputMoCCom44Ih3XQ2M4uNC66qGUnlFzRyOC+VA21xw+g0LNYiaC1SF'+
                                          'BP9MQqIuAVWrabPULMtB/Y/XhDgouQsjKcsZhVqQOBB5LaXlttgd6qwxIBeAuv1dy57ggMs+wJyf'+
                                          '6v3EtUd3XSrFeuR0mGFQkcikGGfKDOyjVIAvJWglpzJNli1ImXXh5z366BPhX/7522FmetY+M0eH'+
                                          'uXe4SZkWo3PegT0C6wz6fZeA67nMGxmK7KpnfnDMu6Uay6K6E6t0KGzbvt2cgrAWJRdGmTlSy3M/'+
                                          'CNArqAYAvC+VsehXVa/qREC9D/N0cFAZ0KIqF1D7f+97P1mQKYpXMnRFq9xxDNUMIPP7S1/Lmvtf'+
                                          'yBuwpDnH93LG+g2bVu9eAWBk5J2obUHZBBho4KcpFiNwAUaAGTIgNMBJjykrygTVex1/QIV3d889'+
                                          'b2U46ijotZfcaM6FO3ZCqS7U6MTgt41GOtWFxkM62XQ6LOWh+qkjnvn4RQtXzTtG4jw1hsqaOTfX'+
                                          '46oDrDa9ml3Sw1NnmGXOiDMCaz52ayVYsOCvVmMar71ttS8WLBYi/owXgOw1N6Dm1CUUGci9RgPB'+
                                          'EBoMHMshG+Dr88QiGq/hs2umw0mEoqZyYJDAK1psctZVql+dAIjYo6/Ha9526z3hpz+9o3ym8esN'+
                                          'tej8EDREp6e3+73PPXgNw/jkpGWHfcc+kO7NkSR5DQVLJfDgnXGH5wKINHQWxTzFM6KfArMHrEWD'+
                                          'pnvpoh4H7je+RwFA/67PJSy/PrMuZll5mkSpWaixH+i+f/AH70qvo+mBegFKXzmlKGXErOQSVqAo'+
                                          'HYOUtaphSw5EWLph46Ztu10AYHeXCqgzM/NhYnLM3FwQ5aXXFkLwUcYMIb6BKed2jAtHWUKgNsPp'+
                                          '9LKXXxiOPOJZrjFfKufqbVdtmOzmVsZburomJtpMG5gpaGld3fcGoOqrgU8g5HVfxXdrYiHzCXWC'+
                                          '/zUILNGIjPzqAZDKXCQvgPZ8N6bCs2begXQUG1+qMmou6udWr9ItRjPrevqF9wNaRr1WntqlCGao'+
                                          'qNQsVLghom6QShnp+GnUR6/CImEA+HNDgsg+/PAjYfW3v+89oKGPXzM2KHtk4uEaM12+6STfhbWB'+
                                          'Ux+UYwF2pO6koEUNxI5pS85gVOjTGzZ9+8kUBrvKkH6DQTqA+p4N5XlJbNL7x+dCAHjJi19kfxYB'+
                                          'SvdMyMe625HjKsfAei5lwxTXn1/z1+HWW++qICJLpSiNS1muEC0qJ2Vbz3KfSuPjzJWzao5ONRzI'+
                                          'mo0bNx+4K/btLgsAZ73g1ItjBPwiFjkANPhwAKjA0HHeDCqZCqNeH0XnNN6QHTFNCzbbpFUTNgBh'+
                                          'qg0jEFEerBfOXnl6eMGZp/hGH5TMNafRGv86p3il5rWKoki7TXLZm4E65QW6sEzBcAZF6shT4bYX'+
                                          'kkhjUeLD9asaALRwFCSSDbbfG8k8Y/KBBzo72zV1oq1bt/vJ1E3kHbHgtPnLjn5VtyBbEAD0i5u/'+
                                          'kX4tW9qKm6y0sdJpVs759X41VQlpQYs6nDwc0mvnabGqIffE4xvDj350ewwAa+09yH9POoT4f1NK'+
                                          '8iYnvgb1/8T4pJUweC0EvlqDQRcnKer1wVA4/LqhH6kiRGtvZJo0oGUT2KYbHnRtwzquAAENGYZ8'+
                                          'A/HZRALCPUOGoCagwFwLfSEy9zJg+SFWIy71hMShwP/f8/MHwhVX/HnyPkjjZW/maW2wlAteEvdT'+
                                          'qVDzQyg3xmgjlaliJeI9T8/MXB8DwC5pAO7KAHB6fMOrzLjA7bvQfGJnHGIWOwwZaFjwGCD6PdJa'+
                                          'DciRQUl43B8MIz5KBqN4+tz7qGMOD+eeexZTWH/XSKnZ0M/SA6CfgDOqhsEaM8bXrrl3gKe5wVFl'+
                                          'ugVGGc1KyqpOiJprvRWVZpnAImreSAmnZMaRpUh779IcYjjMwrpHNttix2mMX9r8+iWJLf2q8vp3'+
                                          'DgBVsciaA0QUBJpGPmqFA/ZfwpTfve5CkGNtWcNrYUpIVNgGNV8lylH1xsO1adOUqdv+9Ce3uREL'+
                                          '0/2JeJJjkyITyBweLb4+NhI28dYtU4Q7ezlhnAVMNho0voBkGV4XfSIJZGRONcfPXrRokWUCNE1h'+
                                          'gJHev1Sj8WdgTYJrRqhn1PW1p4B9yUvPDa961YuDeCT8eSWoR0AvZCDoV+nSJq6ag/z+5e8MGzds'+
                                          'phK0Z06JyedNbZWJcrZmY9aBb34AydNARDj9e41CqVfGAHDFbhkAiH8Plu53IF9tjL260T4hAMII'+
                                          'G7yZN/TTdUB2nwcA9AowusHkoOknB75+v6fuY4CNRYsmEvpKKi36fzaaCssqKMbZTOo2cheyTdvv'+
                                          'ObZgmBBdghzb5tAYJrB7roWgBqFOg+poTMYm9vM8lVVG0ekOwtq1m+zUwuLT5t85A9CvnTOABQ+s'+
                                          'EgCqp381A0AAwEY75OCnmI4/gTILwUnKBKo+gUxZc+e9l9ZXOhXxdQ8+uDbW+Xeb0vLQxUoAAOu0'+
                                          '2V03qDOkzOZLDwbiE6j0DEzE9m073AGXyr3okQDJiIMA967nY0x23HE6YkOWEmfN+OxmYhZhjkDu'+
                                          '+6dAgO9r21Skl+p3TVp0+iuw4v9f/vILrASgQm9IAZfBpp2EPTRGVNNTKb+uL37xhvC5z/9TKktF'+
                                          '5qIDVUkbT/2W/iBlJUkeXOvMMS0KWgrgnIJ0zti4acvq3SoAnHnGqUvioppC+o/xFhpGU3HT40Eu'+
                                          'WrTYEF64EU0XjzQ3nEwILUZIkT7wb1ggeODjE5OcIDgYB9nDRRe90DTcqJrr2oMh8xNA6bFbd/lD'+
                                          'Fd9eKZxBkAHnDCGhAtlMHFQgsiWrbeCdeBl8CnmmbCEJYSyosVUu9MKDD22wOh+bXwHgP5IB/L8F'+
                                          'gIX1Pze/fh177EFhyeLxNBVQBmOb1hqEw9R9JjR1YKWaxmBa5Bs3bgl33nFPuOvu+4yGrddF/T7m'+
                                          'OgzWH7AuVubuz5mRdjDhkJuPFI7wrE3V2STJ+y4c27HUnnN2auuxFzG0LLLVbFQ+f81wBAacsvFe'+
                                          'y/X/iLmYMwGauv0us1oRi+S5gAtTE/AAXuY4AGU4kvWSSpIujPkoflssyIbWrnssvP3tf+q9EpYL'+
                                          'kmfT1MDWYgjJkk7u0JxgMVDivQoIlDvxSSNnMiON03BgDABrdqsAgOvsM08zSjBgrt14k8HVxs0G'+
                                          'JwALBREeEGCN8BDpZ+MpMZ7stLIkdWSbATciRv6m6cdR/w5jRtTsBx98oAUCcyNyyGevN0iUSaWB'+
                                          'tkkbBIuQ9EPkjWSkMreAZgDI0x3heLCWsNsaMaoRpKzhFwJAqNpkEyzyxPqt8dR83FJXbX78vnMG'+
                                          'sHMA2FnWW6/7b2UA1dMfv0C/Puus44OceqodfDLaSr+AErhTjlQh0XXffQ+HBx9Y6/Ps3GS6MR7T'+
                                          'KBfvfQw0bxufNaxzjw0taXh+/YTV4XV/r90uU3Cc9tiAeG5DNxdFAOBJWzi1d+DuPjlp5pLiwghv'+
                                          'asr1/Wat7CDNd7AAI6JxYLfXddOYBuXUQnCNhU4sAc4zOnDZG6l7AAjp/ur568CqsvJwYfOvWfto'+
                                          '6hXpAEmExBDSxCn3iZatFZ9ESYvCSlzpEgoI5BB4lJlYQ3Hz77I9u0sDwMoXMADgYUBuWnUlGKeD'+
                                          'HjXaQAAh6o3pmSmxOpinag0lDsDQm334NwQULBptDrzW2Wc/Pxx//NFWL0oL3vT1hiVPXbVdOcrj'+
                                          '+9W4R8IZEr4w3rxxxxu+kcVzLyrpcvnnatpYeW7JEmzd2vXh/gce+XcDQDX933kCsHMAwMZBk1Wg'+
                                          'luXLl4cDDjhgQQA46aSjwwH771OhBw8rzL3S1z4EafrXwm233R1+fu+D4Wd3/jz5LaCR2hoh+Imj'+
                                          'xdKuSjUtUu5xs4YT3JWw46xGbTtandXc6Ymd+jGX9ep77Y7NqW4+R3qcMKAcRLNMQRbPFpsBTkCL'+
                                          'Y3aJAGAAH4f8Sg0KfQNj9zlVl+rKzVQ+zs/TJv6yy14ezn3RCxbIl+ueCRWqZ1r+O5GEuD75qS+E'+
                                          'G25YHeRZWZJ8MtdBrCUvSwaVehpRD5IcWIl4FJpUPaZa6vXULKDutgHgBaefvGpinHBgBABYOwH1'+
                                          'Zl3OIcUpzTsOsM420VlW+8UHgwfccRFNvS3aVrmOW4sgi9w71zTDrFtmcMCBTw8XXnh22GefvZN4'+
                                          'Q+EPQghBwYDFKuOsnqmX6kY9ZGLeS422Wl4KXZSKsY6oKyTnXV9gQU1CEG2i18QAcPfdD6YAUO0B'+
                                          'KNv5t9J/bVD9ju954oknkiqOAgKaYocffrgtygMO2C+c+Lxjwp57Lk04fslcabykDa8LG/sfv/BV'+
                                          'S/GD6+YVLiiCCQlOZqHscAvQoKXQSG7/jjIKJ32nPWceiGjQWTkFzIMBf6jD77KkDOqOBiTIK7eA'+
                                          'kzmqjw5IREVCQWp8fCxhCpQOb4tlImXjiyT/TaxAK9Gru66lYJOHHdNpJFcCqrrhqne9ORx66EGV'+
                                          'TVckPIRKsKpUnNSC8e/AO7zvz/8qZa/SHND3SBOgygcwTX9xAEKZ5iu7YcZayo8LDIT3Pj09vW3T'+
                                          '5q2/tA7gkxMAnh8DwMTY6T2cXn0+bPQEpAoMrD+IKxS+HNjmRkoPNBZOc3SN+4YMHPON2E+Wz1hw'+
                                          'loK5sCPAPDFBpoGE4/OPPPKwsHLlaVQb9lRW+G4BKUS5VQkiSGvS8itK5dV02ouAlGlsVtZ+aVog'+
                                          'm6s602eNc3DBk/Db3/5x2vwKAI888kh4/PHH02mBTTY5Obkgy6heWCBr165NDSgETaLhhnHDHx+O'+
                                          'OfbwcOghB4SlS5dQqMR9FW3TGMe/SKeq+gHKbj796S/GdP+hJPOtdFsprTQLMmQSDg7CbN9GVY6V'+
                                          'sLl+rOMXL1kcprZOWaBHgEZGSFzHwLKq0gwDNfqMZ1J5or2ix2AigY6Aw6hQOP9Ss2/o0GCagwIS'+
                                          'bYeIw4fxAvjMPaeHB3cSJrMyT3wEZFIIAAcf/Iy0qU3I1pGhZVlUZjzkTjQM7vu2//FeV38Wsayf'+
                                          'WKy5A9QYqEOaqvS955Feb1BK4mUO9qnlJR6BWWkh7MzqGAB+aR3AJykAnHRNfAiXD22+yShs3u42'+
                                          'IurbA94S6zbYN2UGBZ6jkQicbULNpgVIcWIWYT8Pt67X6TlcsmGLotcVsmzevgL4Ac59S1fe4559'+
                                          'ZKx9Tw177LGMzSlZi3mZkayzCmrbW12K/kGeOVRXtN56WnA6Me0UHA5TdNa/4yqGRaX2U4+A/3b/'+
                                          'A+vCjTf+ZEEAuO222yyNt+9NkmR53MBL43vf4xfuL752w4YNdOuFiEa8ryeffFxYedZpsQRYkkZS'+
                                          'DJahZJ5Zit61+6/XqfoCfOvbN4Wvfe1G83GY87Gb9VaEG3DGJU9uIgkXLNCEc2cGPBpPa8Pfu2KT'+
                                          'deqNvx78fZHjQAUfv3/+M1Em4j5i89okyfX7qp17a+a1KdyBJiAajaa4hAaawRiGBHv5yHBkZCSh'+
                                          'IjFeRpCFFJjGdAgAhx12cAr8mghJYYo1falryBJsPrznPR8KDz601j5T3cVr9LoqDYOr/jZd6pwK'+
                                          'Uv1Qmq/WUzZb84OIGW/LhW+DN6ZFvprfrQPAFSNAAzrDCyk3NjdSMhE7Nm/eHEAYQgOq6/r8ODV6'+
                                          '/aGh9aQYjAiNrrLqMpweTRf86JtKDu2zm4YSox5/1xeTgBYrnrF/OPmkeDIec7gtUoN3NuuWiSRb'+
                                          'piAfgVCmcd4MatTr6UQsinICkOy/fZOrPmV5USreJsuvjJBbQHnv/Nl94bFH14cHHlxji3DdunXp'+
                                          'RFc/AH/ec889LRDsfKlPsN9+e4eXXHxmPG0nLXXme2YAwuldavD17L62211vkNYWaNUBffmnf3pt'+
                                          'yo5kzDHmRiIKFn0zUxk6x4OcdrxO1WuPuP55e37b4nNEtsualkHYsqecfYSaswZzT4lNcyFuEnD9'+
                                          'sV6AEl28eIkBwoyC4VqNfQdo0eG3pMiq+2+S4P7+8Gc2H+t+EtO2Cxnili1bUzD8zKc/WJH4WugD'+
                                          'EEJIhB+NEnG9/y/+Jtx8853Jv1GZQ+HuzsL+G3jNad74w7BSjkkWXdmYgrJlU44Ytb8bDpKQTHt+'+
                                          'bvcNAGecdtJlcWNfR+x1L4l+ZIDo+ofYFAPA4livYgG00e2FSWO3n2oeQw/GCG0dYAeO5CaG2U1N'+
                                          'JKRthKUO6YdX8GQauBgnTsDt8efUHSm4fPmycMihK8JzTzg2PPWp+6Zmjj66KQMPqhLZwg0U7lU4'+
                                          'SGkfgS2E0VaNM0pl4yIRPKpTAgYYliFymUFwfOLxDeHmW+6IgeHeWA5sTGk3mnrjngntfB1yyNPC'+
                                          'C1ee6Jsnp/goNr/RU+uGvgw+Dk2Zy2DopVKjIjYZwpeu/0a46aafhEVLFtmzwnMzfwcH8BhpKQZ0'+
                                          '2X8hiPd9/IrXR+NPARElwMzMjhi4loWtW7e6tRWhwJa+zs0nMQv0fvAzsTHs53kAtgyvTpEQU/2N'+
                                          'GWEyEAEVt023XwqiZEYPx3vED0BWIAiwTXSKYfJGzGt5cgMecVMRPZcv/uPHnHbNtYTPJFJaVSlY'+
                                          'WR9ovt/5zo8qwK/hgs2rZ17So6mYJOn5mjv+ZLl6UM0KKzCzDS/EqsBq8gmIa2Z3DgAnnh4f2io7'+
                                          'EU2hhxr0VPSp2VgPix7SWMbHN/RdjVTOrERhFW7KQVRfcIUgLydaZGrhZsxZF9dVZwtJfhV2IsKe'+
                                          'DPNnjatw4ediNAYbqIMOOsB+T0Iew0HCAhRFVdc+OCadpQy+Vgw4CxLJY7BInX8Oe/1UTFJhpfc8'+
                                          'VWUGyeADix6vv3nzlrgZbwv33rfu37zHBz1j33DaaUfH07bpugFZYi2aAWm8P+ihcFGxkSX/RDHV'+
                                          'tFCRkXzwg5+wHsyyuGnxfinWMlrScrGxY0DoGxy25ROakkG5OJ72ZhEGnIaLfOCExUke/FRDQ9Dw'+
                                          '/EbKatLK3K3ILYAa/ZXsP9ORSNoAISn62PvJaRcu52j8DARJ+ADg66E9KXco2m+TXi0oMqXIOzam'+
                                          'VkMWzcVPf+oDxheR8xGDdUiz++r1qU99IXz9G98tJdXTRcJYGlMGH0W6oIfMUFMDsU6Yr0rIqktw'+
                                          'Fc0oVCaeGwLf9I4du3UAOCBulodxImGj2MOOfw8QkLGsTNIoW4CfF56aEZbMPWvYxE0xYuiublIJ'+
                                          'xoNGf8BcWXJaR5vTK05UfH+jmRiDCA4aP7GDPXQVHR//9TmGPOTgFWHfffcOBx+yIizfY2l42tP2'+
                                          'XQAAKufig1Sr9t18sor7ByY5rxBvBBdmpuBAj8yprqFIUwCz97KR18A+H/5uw4bN4Xs3/SxMTU0v'+
                                          'uL9LloyH8170HAPFUFCEqWbdIcC4v8i6cGITY164bVc/fRbh/3FBmBNQXtGkDfzjNenI6KhrIzAg'+
                                          'joy2vKSbTfThEobMRW5Wob4p58y0hH6OVv97im6egAbR7VoTmMIYdb+nNTb6egOTPRe6U0YcTVdL'+
                                          '6nlGUfjnsZLCBEPaqYTDe0Uww0EkiDDr+oF9NqwLvEe4Ar/76rem+l5pv9YmeiG6oO77kY9+sgIB'+
                                          '76WZv2TcJBprICdXS5KmgvAkOhhwONbq8gZ0wQ+Jj3iWVnd+BN4bIfK7cQaA68wzTimsgQFgis90'+
                                          'wQaE4MP46Giy+pZvQNsAJC1b/C1L+ej+ahLMo0wT5UKLtLDm2gB410gDSQohumvEJaLwgYTnFhCF'+
                                          'nHE2AnVT6V7Upd6fj4Tw/mBYgge/zz57MZ2OD+XQGCAkB4VNt0cMFosXL2KDzV1ipAJSssZKDzwh'+
                                          'y5CZYsNjwRMdV7iSb9+VanqW5mLx/vTm+8O6dZvTvT3nhcfE8mmCxCfzDWh4U6pm9w6BABu/0WjZ'+
                                          '71KrlcWVxEoQgMFHeM+7P8hOd4t9FNyTyXh69zpE5NmJav2bTgqieTr1sPDdrhqvHZ+lkXOadbPn'+
                                          'Qu0d7Llx5EVUZiMx9IwBOBAevmZrBGxAfHaKgHRdCblrgQ3Zg7QbcG/qzvyUw68F3qHGjMQUUGuQ'+
                                          'nx3rCsEHh4zGf8gmzjjjpPD7//fr0z0WQlHPT5nejTf+MFz7V59ZIHMuVqBGe2lkKxBKKO3eWRL2'+
                                          'HOfgTslpJO16hj45yB3LgPKWdnKZ+SUgAE5PYwqwZfcNAM8/9cRbY5p9TA1gkfjnGaSUOAXmeRKT'+
                                          'UFKzcaDGaibNhLrexhxztiDYSaWUd8hUH/b4gEbprMPIn6fNRJOQgTnw4M+GRIsPueE1GQ0llOIS'+
                                          'JCJaMFWLuZBY+5ZKLFL2lSWVBaH48FaseFp49atfaoFCF0ZSdXe3TSCQULIJ8fmnp6edr89JhkRU'+
                                          'kRojhcbYC+8Bv99+x9qwZu2W8MzD9gnPWPEU2xxU0cntPshzEEHMiFj1ljWQmj4lUKpNJ+JeqlVX'+
                                          'rfqB2XHXanV3WYrBtUHzUgOk+EIfnxi39NjMU4ZO2e3S86/eYC3LsWJhmx8p9ujImEl0mTOvlTnB'+
                                          '4LPYrGjeYUyJ8S76LlYWuKw3yGLA9yOTQ9Axi3AX+6jyIrpOIFNwSFLocve1VU2r9bZPC0Qdtkxw'+
                                          'SJlwfN8rXn5BuPTSi9PzE3mnmt7/Vdz4N8aaH5dO+FLHXwCfrFL3Zw4FL3UrFzIwhTEYJgKaXLHM'+
                                          '+89FUZSxob+FCRU1EmdXb9y0eweAVeNjo6fXXSEXER21IX5HU2fos3IZMGhsxpS9aRuCeOtx17Vj'+
                                          'FFRQRYAQbRIWUg0f5fDh9SrwzXJMpxMQrwOhCAqTlLNejcNIJx24qUQw/j6ceMze280nREWk2AUN'+
                                          'LC595cXhzDNPSnp45Dxo3l2kBz9wzUB0uM2VqNfxzKbt5h9Dy2qQ/va64gl0vfzIjBCDE9lO/mbD'+
                                          'MicTpgBpJ24aBoGW4wNG0jhQ6a1OKLzHP/7jj1hphoDScOFLBA5cNTfhwD0CqAcByrD1FQkz62D7'+
                                          'nHvE2J1967kY3Du+Puy4bPzb5fvHZADPDs99fHLcZrwIgKj58Qzw/xD1wKmKTr7gvBIsqfspa56O'+
                                          'bnW2fce0uy3REBZrSO8JADTcWzURRRZS2q6g8ba3/k444YRjg1ynq1ZfuHDqr1r1/QWgIF061UMo'+
                                          'BV2q9mj8c5b8HSSZLw6AQGgWALx3lIKPTQwoE01cQ2bZYryfu3sAeJ6NAluW1nesS4t0D6cWVV1K'+
                                          'xxPhnOfa7vPui2sefu71Jo0pQnAhyfi9fmPs4blgBDY60s1GSsW5MVGHilxkH9LBNTiBMj8dKLM1'+
                                          'dJNRGY+4gCPhaXYyYR4tDYGBqxWNWBe7583MnukV/PqvvdTZdr1Kk3BoWPfkFTCks8+8ZRv8WW0T'+
                                          'xOjxZOpSHAMbXzJfOvHkKMTUn5Bf+gjU7bSsx3uGMZ3Zkcevoctu39JfCGnoRALc93Of/TKbVgOy'+
                                          'IrEB8fMa1ulvpcAz4YCgrney5QxMEw52v5GJFA6x7vWG9tzoRUC4NlJtZA6whgcbULBrZGfsExXp'+
                                          'a2wcCmeg+LOwqRum6tNJJK6hjdV6FvC2b9tm0HBClFlWiV4sgFTbXYawtugGVeoK4vrLj/6xTYkQ'+
                                          'AKuSXihn/ux91xoXgs9zoTycmtZSXG6kgD8sOSUmLiPquLta993mzPsmKherQreJpu7rve4AKapO'+
                                          '9XbvAHDaqc+7fKTZvIbkjI7hyEt1GJ52OJkklYRUTI0l/BmnRMtPImYMHM8MhjSTxClFi3HKQjPL'+
                                          'IHGjk2Sicq+XppP89sBhtqyzizARN4RZUYmdWKsnPECvAv5RM1A4BplNIsCZnr+VLzz1TnjO0eF1'+
                                          'r3tFks8S807mnFQQbicRT/P46/cM1YiNL5nvgVuA9wccCcrRSLZiBDFlSVkY92nUVJeZIeD0M8p1'+
                                          'wdEjNr8ufF6c/uvXb7R7IzBWfzhIZJ2m3/fCRVU5U89tFl9zqXOdmHxWpQ+A/BYhyLkjnr5jphHZ'+
                                          'oRWWG1vgvuOBQSjGWHqgBMe/Qw/H7LLdtAOBc/HiyUQrNvx9o1niPnwz455IFVjlGbroBBSxqWcZ'+
                                          'zgiRfzIFwfUPf39tkP+ggvbatY+Gj370U8bwq4LAlP6zATl0Vd/y74ZDEcaUbVFKPfdGbekqlXlD'+
                                          'vJamDbpyl4fLHPdQhZ67HPj1MQDsMjGQXR8ATnne6fFGghNgpzlOjtzHbEjxUevb5nDiBMAwaPih'+
                                          '6ZaZo1A8rWLwkG+aNmUnPqCu1/WqyzMfbclYU3xtnDJSE2q4BBPdZJwOixPMfeAQjOR7bxx4VxiS'+
                                          'VbjGNGJzyalHDy+p/wxZC55wwlHhste8LCn2CJSiSQcbf8EEL7D5O7bhB3afrFk2pJ05gogx+Gwh'+
                                          'l2KnNWf9ISU0OnMMACPe9Tfhldl52/z4WnAk4MRUkmiKcMcd95gpJzYCMgb6Boak2FvHuMlPpeoM'+
                                          '2sZ4yOjGoOM/z0wEGZg5/7B3gqDPcm7OGq8zMQD3vekKZC++dxA3NVP3URP27Pb6ziVgnwKHhXH2'+
                                          'HRsAWDFGin0vzTQJwHrB9yIYgY2I0kMNYvw8BI1h0oDk6BXgpnaFe3H44YeEq971lgW8fsz3P/Xp'+
                                          'f0yZYmkK2kipPRGOWTrpq4QtoQAtm00GL6WegmTEZEJrRDSfMAk+Tm+DzJGXzPD6XrrEzOzKGACu'+
                                          '2J0DwJL4QabAz6ZpZ9MetKU6Bc1CcA/HxkdtUcQPE2/Q0BYMFos16UZalMRuc0TYsqnAXMLuG+MP'+
                                          'depg6HUkU6xZ71pTRprecrlDfwXQSeg9yyT6Ds/MkwwYMOY2OnPzyAWYcBd3QC8AEb1mQaab+g3d'+
                                          'LqW4Tzn5OeH1r3/lArSg1GTxHvGLqrwFba8GFMDoOvgJmQv0ELCAEBwgH2YoxzxPoqKiAM/Ndbxu'+
                                          '5Ek4uWgi7LFsaTj00GeYDkMViIT/f9/7/jps2TLldT2bmobDd5psw0a4TJkB7MkCAxtNOVjC4H2N'+
                                          '+MmP+wLwFr4GWAKsplmf5CDF1+SGtlYNy37wuiPGJeilwNrzYD0wZeN5R1i27Plg0wqYJEan1J3x'+
                                          'dwgAeCa21vCz40YHcxTBFaUgMkzKfQ0SLgPr7OUvuyC86lVsAOI1weqTkq82toxgdP/EE1BjUlqA'+
                                          'VDLmdhK1muSybAH8tyoIIl6K8TU8mA7dG6Hm+oVG8YZkvBnMGL9jl6oB7fIAgOv5pz5vKtZ+S1Dz'+
                                          '7bF8D2vESAoMUQ83e3Jy3NJjdsTLrjmCwMDlnaXhV7MUnE2bXOouHpGRrqNWRjNoenqHpbXbprZZ'+
                                          'PVmaVw7sVBw4ahA3XEYcQz957EYYfmDOpw8umoE620c5haPKMLJEKjoYSlwyc7WZToKdnnH6ieHX'+
                                          'f509gSqKDAsKhqT43Ahe2CQ7tu8wsRAsVAJUOobdJ+x3kPALBEXliaZq/Psma32k3ItiurzPU/Yy'+
                                          'Ygt6AVDpqUpb3X77PeFzn/vn1BeZjhsX318601B5BgIf1mFvEFswdLcjNBYN2t1o2AmMwIuMDGpP'+
                                          '2NB4ppIQx9fjc/WTXHpm0GAgFfG5sDkF8ML0wE536P1BMcmckYbWhMX9EP6+2+slx6F5twfXuK1w'+
                                          '6Xk835ZBiWfLkqRy/03EZJ4GKldf9dZwxBGHhrvvuT/85V9+2j6HGnlZ6gk5qhN9gFYz4TuqYqty'+
                                          'TxJ3hJOBPL1XAYRwYU0hY5MYbZYJOswJkdSLmGUQO2MKQyE5J+3+AeDUk09YNT4+djqiMrq/SPmw'+
                                          'iEASyTwLsNrbOuGx3u2gySUkVddFQdgAMhiuW1J1XBWI8vxFkvBGAJC1Fh4+kG3IKKSLb02sbtdd'+
                                          'hPo2X9aD6wtJaAjCpvUgsPBxQuDPNZ8eCFeuxZFZg3A+GZWIhy6FV3zdic97dnjd617uuO/SbBIZ'+
                                          'ERYoAgGC4XYLADMeANq0/Pb0Vs00MejEJ8fnwj1E6g/fxSWLF4VDDlkRnrL3nrbxraHnBqR1l7Z6'+
                                          '73s/bJRYchfkbJvb50TgGxubsOwJjTvM5etNUnat6eYwYDXm+PP571u3TlmtzuDXd3fmhgU1aEEg'+
                                          'UR5ofFZjQG+7hDcyH1O9xc9vkgtivhJoRFoApETcwB1+LfhBGHMHDWetN+BTnnnPNPF5AAXHRrPx'+
                                          'crPhkwtOphB8cf3tZz4UvvCFr4Sv3rCKm3lY1uLKFORfWN7/8hSXpJh+fumbEFKjUTbvMmkNTlqS'+
                                          'ZkB1SiDxkcJQrx1HnmZOZefYMAbBX4kAcE08ES7H/JJ2z2yWGW2z3U4dUaZYXXZ5TRCBRhcYGwbX'+
                                          '4scCQaPK0GVucIGbMeNOuEYmQtBAmu71vHzisPFNMWZuNslO21jIxzYpxXOyBzYMm5TED1gD0efL'+
                                          'hsLyRSfPOQQ4BJBxFzSV6IamCthcJ5307HDZay5ZgCZEAOiZQk3HFGtAK8VIDgEAAQj3A+WA6SH0'+
                                          'eguhyX5iNJtS/l1s6MW99lpmnxWLvmGCoKOpQYfX/trXvhO+8pVvscvs8FZL+xFUXZpa7EVStymF'+
                                          'NRDJyZqDjTTiNKDWWCvU473AZkMAUgAnacbdgpC6Y/zW7zu7rkgbWh6OJvfWGiHIZ3bGAl/LLeZt'+
                                          'Fu6NPWxw9DSA3yC/oOUNxeDz89zuH6DIU1NTaexW6kcOk/7C3jFQoiewOZZD6vJTgLZszOlgqGZv'+
                                          '6toLCoz1Ua+k+7XkMFUkOHDNDxr8YeCnvBSqTPeyyYlF3Scd1ouy4JonGD1IZkM2N18cA8D1u3cA'+
                                          'OOmEy+NiuQYPEYucNXvDQTCztnmsa+1TAKXJOukMSuxpVa/Ljj89BznSwQLcvmMmKfHi9MREAA/P'+
                                          'DCUSe4ubptQGIDtRUwJuslKTMHeZaOMZAGVoG7uTRlVWknhvQf56dkJBvbjXdR43AUNG0HEnIfQE'+
                                          'XhODQGmn3XGd+3ZCAKJutto/Bhlg9PG+EAhmZuaswTk5MeKPCijERRacli1bbKc5kHfGjIwnNNyG'+
                                          'bLYf/67lXgdT23aEP/mTjybpM+HSBV7BikfTFq8PqjYmEgh6SOulsmQ6AgbVDVZuoNk4MtpMar6L'+
                                          'Fi8mx72iYixKNTZu1915xc3oOwoQI0SVgYYnMO5I10FRnQVCncxOxpxKzLRcrkdgoOIyDsgoAzd+'+
                                          'Du6PlVLeVJR5iOTTqhLvO/sAluM+Cb923RWqnwRiDbQzqPQCfN5favj1UgmkvlXacQ5Ll4ioAk+/'+
                                          'AjQiz6k0cIUjUAwAq3f3AHB6/ACrMGpDbTc717bOPEdKWdi2Y1uYiDU7wTR04e04dJdsKSC4OJ4y'+
                                          'cQh7l2SKWSOn1fBRFF1WZxx8gpMkOCnGNnA8rWeALKzlHkC6zlwrvf4squd5eQrKI76gwAVSY/vZ'+
                                          'PnqiQmvPLb3oXiOBCZqchFTGdJ3nQN4+gsBLEwx16DZenPMT8CPgD4MXU8bM/QrZFZaoRC2JpyLB'+
                                          'xknGPkSLcODWqGUB5GRk4QMfvC48+sj6NPLUZ1ZDEfcBsGYERJClKMTCjdJ0J6G6+yEqY7JU3koq'+
                                          'NuhwgguxhiwOp7s1DZ1pSWZni2q/CA5+6ta8Jh+6ScYwTXNCkhOXQCnYhJkLZskHEL0ABMO6aw6Y'+
                                          '1bv3IPoOyhLGX05AuPBa8o0sIb3lTF5MPy69LPH001jQT/W625yJeTqoqAeV4z2imohUHZaOv55t'+
                                          'JKGZvDQIHTh3QNOEJC5ShDM2bNw1lmBPWgDA9fxTnleADYjNjI6sZsDNuHmntm63bjXrc7nVOife'+
                                          'u914UDWPmPg7nFioG2UCYiOsAR1ntLiMWGOgkcz6ChMTDEC48IBQd2vEIt4+bZ0JZNEDmxcarCis'+
                                          'A02xB9axMoEgK5AnkjUXHXJLw8xOavzgc4nWq3JAFt7UBey4Y3IvKQUbYmJIOupgKFltb065ljw1'+
                                          '42t+io5aIMB9Q0c8zxvOChwNN974o/AP//AvbtgxkuTUBIbC6Y2gtzie4H0H2NTw2bqO1c9qpoVP'+
                                          '6XV6EkoMRAo89F4YJMadZW49BkmBtPDMBOs26TQXZDVMBzgYrsUoVqaAWR3PWnJZg0sKrk/DU2uq'+
                                          'IStoz6cyo9vz5q6dxGQx4l5Lb1JqSmWav1AeTZu+2gjU5h84RXdYDBc2BF3PILj7sPoCFGRpuI5B'+
                                          '7mrMTXvGYnHi2xX0hMVgCVCndL4zTvH5NmzYtMv365MSAE4+8fhbx8fGjsnsJGRNi069+bXHUxnZ'+
                                          'gZ0ojnkeDNkgAi4AegCWJnfS6MNOOTNhHJaWT0bgMehorPUt2NSsHFCUDi53nbuqqgJAqfJCAQmc'+
                                          'MugN1N1co+/wU0qP9dLYETU/ghLeJyYBCAocUc57XcsFiMbTpH0GApOMAecd7FNPPSH8xhsudfGP'+
                                          'tvcCIHLSTTU/4aXuruwjPEspk94gnXaFC8idHIQFhnucuffgI488ET7ykU8mWKqAU5RdG/UMqGvP'+
                                          'AfN24Shcy4L8+w4FNCitHcKO7dMJizFm8Fr0WZjyYtHis2gEZqAmR7DVHfuOKQbKsJqz+RB8sD5Q'+
                                          'gnStH9R1DTwuTTXHMBkwVOl82zfDIJWLvOezyTPA+AIO3JJUuAxKpFaM76P5aH0Buq/qAFVN43Gx'+
                                          'WVlbYAsmVCgOg0ZjoRtQs9FI2SKDOte5BZ+KzJgEY5hZ1fzEdxk2N7KxvksMYr9KAeC6+EEvw+mE'+
                                          'DY8bZbbYOdVc0cwRSs7S7n7PsOAWABxF2O0QjgqEW90927quwCLpaaT30zPo2NfTiYSvwyaUpZIe'+
                                          'CAIJF0aLzS+3b+q6USYfcp7uSBKFwDTCFhUhqggYc2Y+2WJqOssyQRRSnDYIAAL9YPOYE40HldMx'+
                                          'Ivy1SwzvT3Uj6hq03QSUQdEzo0oAwCV9OwpfEgwkTYCGSYWNxq+phY2bpsIHP3Bd/FmFpeQymNSp'+
                                          'NuI22YQW56lJS7HUwmHAk3HRsRQbNXZhDNCxfBs12HE9EV+MeOOno+DYCIyz5txTS5lFwycqCp6m'+
                                          '/4cAG//QsoyLDUEpKukzl9j6woNKYT+r54YyKAOSq7Op6YwkJuOsN4uRqWFt4bKSwdNwbgCn8Sak'+
                                          'Xp5Oe4HAhoU6/q0FpYEap0IaVvsfCLJyvgqZHJmzBTtOVmjKgA00lckaveHwaxLmYlm2Otb/uxQG'+
                                          '/GQGgMvjm74GZBIQarrGyc5NDwDz1iUx5cRJgPQN/46Hiy5929B5davdbZQ0M2sY7TZsmcZGuWhr'+
                                          'HNOZa4qLRJgWnneXcfzg70ZHyeUm7z64Ui/JJ8OkvusGH+5JaCNDLwsMpYcH6Qq5bderKzyaW8pX'+
                                          'BG/acLJhEN644C0AzLcXSESnlDN+/YEr9g9veuPrWJ92O1ZqsDRg0GH5QAyAsOClsYnsopldAGBj'+
                                          'vgA2mmuENWseC9de+7dOXy6bWJb658Saa4GTKDPKOhcQZIBnnAq8eHKxbR5sWJVEVoEX7ooErX43'+
                                          '/Rhzbwex96TLL329hqP08PPhAGyGHvjMltnUvV8QTL5szmf8vJfOz683LOiKr6/XxcbAydhwSTj8'+
                                          'PDQWaZMuPwRmP5gMCEClno9AO8q01A/QMwtBSsFZKh8USOX+LEVpidCyd8OsR96LBMVxo/ddCi13'+
                                          'z0g5SCsjINW5SG7IOsjagAHvQk/AJzsAWCMQ0RYvIX6+QBjApyMQ4NSX2y6ablhAJt9kX98y2jCh'+
                                          'kDy57YRH59/x+DJrsMXpJ5Gl285YCz5hUA2n1JTd5E5K0y2ddBaYnRreTOy4mgy+T9JO+H51dSU0'+
                                          'igUcDJrMqQEWOE9YKbo07efq5CVjrxl+73d/PaxY8VTLIuhP0EtMNZl52OaRoLZTk9FM1UgQJ17u'+
                                          'GP5vf/uH4YYbbrTNT73EnvPgGTQL32RVPT1sFPnco2eyaPEiirMCku1KzPY5gPEHf8AptuzcU+Vm'+
                                          'YoIycDjBsTm3xixvSSwdIPtmwuE+Nel0uhVpcsqGaz4OXQesC8mj4yKduPAUvp3AMzQg7blHZEb5'+
                                          'sFj+mc+EiWcyoDKj433D58d9VwmoE36h3Xkvpf/qDahslLuRGn5CgaqRqLqeeBRmZmL1sVQYDbKb'+
                                          'l5iJBFcbHmQIHy4SD8CwFjUKsMR7d+WGjZuu+JUIALhOPfmEQuq1GGepjsYrYsbMUV4tTE6Mp46v'+
                                          'Ic2Qys93bWYMb4Fum86wplrTp3QyN2M9CVkUvliU0opBZ4vBraa0MIIvEgk24krGHh6V1eEPWUgn'+
                                          'P+o5k8vGBAI/o95IjT9TKapou1fJROoBcDOS6KRaE+/lrLNOCWevPJW1dI8BgMpJvhEcBSjMusma'+
                                          'O1USCwib8Pbb77XNj6DabDaddFRaeMNPUSceUvksK5Kyj8mdeXDF71YaOVNt4DLohSH5ssQUbFhA'+
                                          'aVuq33QhkhmTASsscGzdstV+N0ehPDgV2rEHXfY5lPabfiOeDTr642O24Xs+VkWgwwbB5teoDO+T'+
                                          '4i8hiY1gPQFLgSCKgNg2xuggyc3JbAbTjr5byAndqTJxZ0VnBQAdEEkVyrkAgv1mrjQkCbSqrbfm'+
                                          '/0OfWMn0A1fdN3bfx8tCEJoxjRuP6BmxtzB4bQwAH/+VCQAnPu/4W8dHR49BGoNxXhEXx/zsvKX6'+
                                          '+uDAkUP91Zpw1qmfsZny7AxZW0C5dTv9hAWwVMvAI31fDJ1kBoG0tea4fXrA99NJ3HAlmKGDjwS+'+
                                          'SAaZgTV/x0Ux8bUmOYaTpsdxIdK4ZsXPvdXieJA1YuGCDXMVOmqp6yZnHG1kWaHV/e9QB66MgeCU'+
                                          'U57t8N0SGyHdQQUMBQBwBH7+84fCjTf+OH5tkTZDq9VMYysCbnrWROWsuuYErcwX/sBGjsA8mHWW'+
                                          'TRgadg+6PpJE+szsZdSUmSWzNutWb00f35p7LpqxLtCKS4Is9nlzFxG1Eof3re/aiAOHDIsyKwwB'+
                                          'y7JuEoxBqUbrcKbd1jPp9aynBCViXBKJIdpx6CUgxUCNxp1O60YyJq2e/Aq01cagRqJlf2hYOflD'+
                                          'muVLIKR0YypSxiFOAALp0AOPsg+NHWVeg+kPsTJ5Oljivx8bA8Btv0oB4LqRVvMypPkGzECXN54a'+
                                          'EziNegOLohs3bQ5Llyy2bIDBccjxncuGaXyixW+2397VNnFOo7IOk2S0HF0N6NOjWEPPhSDhQoON'+
                                          'IDfZjo9eks6/j/0E/EFwUv3PZk5uNZkMJgE35siLasSCntKqmzJUyBjUNFI9q5GRGmZCNLIz3w5H'+
                                          'H/XMcNRRh8XAOBFWHPhUfkv8b/36zXbCr137eHjo4UfDo4+ut39reE2LDSlXYC7gkEaRSn2x2HBy'+
                                          'o6+CIEge/SBmCOMJbov+RRXRZlOP9pwFP21mG/Ha2HYQM7ixlKqHjG5MhsWYn7OMDVkCpjP43CNu'+
                                          'tInvxYYdOOBoGtJtEBTxOX3fyw00kHEZ/6Lpakjxc9F3kv0DZE0QIzGvSRd86XZLp+lZ9yRAn8LK'+
                                          'Os8GnF7r7Ep/NKHEAdT99KeQa8kRSHx/f5bB0YYkDtUWaF4qS9QzT45Sg35pAW5z/2EaAUoUV3oZ'+
                                          'LVPUmntSJgBPbgB47rMvixv0OqR1oALPxUWEUwbNvL6LZCBtgzLrXNwM/S6ttdREwgm+w3zhRqkV'+
                                          'HzcUp3+utx7/nbz8YeocSwewKELqJEshZsuWLTS88DQf2YYp3roVWC78gasDqVYnoISbgZLnnWQb'+
                                          'Pej7WNJPL9XuWGg6HXQR0MK/x6Indr2eFouMIzQ/Vp+BNmlktqmZZJMOqCNB6XiCY1MTQpmYsM+D'+
                                          'RmrVGtu0A/I8GbZiUSHQChcPCvZgOPByYIR1dvyd3Hz6+HXdTUcpMLKI2dl22HOvPVznkBbkFCmp'+
                                          'OcQ7Txz+WZNgozgoAun2+OyRDYyZHNt8EsgkN79p9wNBe8TLk6ajQUe9jyK6rQWkJoO2FKAU+Jh9'+
                                          'zXNK4tyFYaXBJ0co7uUiwaNLNecsZauCVZe/sqT5QK4/maM0AC2Vk9Q/ElZF38MMME8iNjZidsyJ'+
                                          'Sb4XtLc3gdPZudXx9N/lE4AnNQCcd86Zx8T67lY8TMyncaJbx9463wOrXW2TZHnyBeSJz0WPqIcJ'+
                                          'AQhFWIj4Xi7EgZ1IWKB4dNCsQxqLFHPUNd9z57Br1IUbiy4wxTLzhHajmGY9kUVw6suzzUhGpltP'+
                                          'lNbQR0wdF6KQ0QTeNx6uThUKm44scA2u/rJFPDpqJ5cIT6wXJR7hbLe6tOQKpvXeAGuaLFjNiD1A'+
                                          '7hHPwJEp3XU5xWCt3ki6iw1vRAJkxFFYI3nUiY8ukVRDuQHZmLFPssTKtGkP3v0k8w015iVLl9lz'+
                                          'Mkx9i/Jg2MjzuDfeYMxcNHTgI62alyI9z9I04jPxUdN1HDVTENbm3CB4bQQN+g2wn0A0ZUF7cP9Z'+
                                          'NiocDP3fZ20DItgFP1Ts8xmisVF6QHi/RvW+AnXV20H9AAp35mkcXSIEBx4kHEAU34NlPM4BkGVc'+
                                          '5hLgpQ6BN0md1IQ+ijFkDWzFdRUDwPtjAHjjr1QAwHXSc4+fGhltLcEDYGeWpwxHZw3H19ddJy3z'+
                                          'Bg2NIKbiw8ZiAkgFmwqMQdSq8plruuuOal3OXkfMNFJsNaLMuOGpjddIqTCppuQBVBeU8bMN5tr1'+
                                          'eXGw0aBMMqxPsWixnSziA6DE0M1se4rJepK3tzp3VybAOl2mpFlqRGq6YIw/d9vB/UNQaLrUFTUK'+
                                          '562pha68qK9A7XW8tFDjTlbomjfjnkw4XZpuubnPsVtu1sHyJLfGacsaksRYUOnImIK49zgBjdDS'+
                                          'NJAOvsd6B6a2PDASFy4h5IR+FM/f6K85fQuxaXuG+Byx91z3k5gjQSoBw+bbsjt3LO4P+imYeiZu'+
                                          'pQKFRdjrQaaGZzDqcGnV24KDV+XgdvZ91Cgw9QRCSNh/SX9J+aeuPkfaUVlCAUoSnz4FLPdaTUq6'+
                                          'lXL1Xm412IMx6XOY65o2pn3OJ6UB+KQHgOedcNwX4wO/eHLRIpvp1x1Db2OVDkkfmN/nrrFGym/L'+
                                          'bgpcYbEoMLKDIAjFLwWrpKQU2VRNl9eiN8C8jbsK78YT8GH0XtfxaxileGjvZ9yxBbZJHBVGcQqO'+
                                          'ZQY+J7ZRozfgtIEJDMrcYGLc6nc1F1UK9Py0xAIBEIU6fqX5iObRXHCuIBPYVMRoDV/Xcf0BCUlq'+
                                          'M+HeATWJTcGUmaUOJdbYiR51joRBhkdaKRtAxoANbqArhzvj55O/EBxmnFuvwNLa3DX1488z1596'+
                                          'w4k6hUGEFy9ZlMA0BHD1E6uw5s0u3Auz8DaId6A57OiInch4z9zYLoOV0e1n1mXb6BTUMDyIjFqk'+
                                          '52DmIPOUE6eIKJF3cKhWlx+fXTx7CZzofgulJ/To0Jl+FiBHRjxTa3jwqJV8AjzL5Pbb9/7U0C3k'+
                                          'yrLCuBI+8bCvc36HdAYlQCyZcPJM2gZ3NwwMdQ0PXL9h45pfvQDwnOOMGYj0jaclTiDWZAD7YIGi'+
                                          'NOBIpCDu38dQgJ1aJx3pElIspMC13DlxuZUIYvkRtdfzEVdIsN+SBTiTSD0y8UiUTutgzzvkt56c'+
                                          'f4QrF34Amwpfh02GN6GUFp8LJwwCQtMZeJT9bqdggEtsRrvpfkpYKdDnjFgnEC6Ns3Q62oZruW+C'+
                                          'Mw3NxsoUb2aI1e8PEltNykiUYqfWIMdyc2YlrjJJAB58PV5r6ESo1ijdnQD3pWFLP4GfZh2DYcpO'+
                                          'YyMMjDWakkKok6KhTdp1Icvy5h20FKWuTGBV1xqGomkHD1JdJ33Z1wJYVNO40mtzV5s2qjF6SraG'+
                                          '1KSlbTk2jT1T7zmMmbhpN41P+/7sJfUlyHEVDizOhxmjZlx1ytQGDs2WAjUypyLpAfr4MHAMaO5K'+
                                          'pm/gWhGVjEN9HmOZuvBKFgQyanhZPFgTT/8Dn6w9+iQHgGOPiR/qVnwY9AGQrpIzTusmdJynMQEI'+
                                          'pRXTwOGoSP87nsLbAxkOEz6dM3qqwQpuihMGG4mgkrnUsZXcs4w6EYQozOgyYkhvfW6ObISBJE+O'+
                                          'skrbCDUd+BiODrE6KSSmWaUXK+VVMzBuvG07duxYHf93Tbzpp8dvPgZ/L2KNAoMMRbChZGslZxnr'+
                                          'YLuZhppWdu9oi5tKi8SHsE3VTJh1vD8EHQVEQWK7LvRpJ5UbsZAgk1mfYW5+Pi1uipI0jIAzGp8p'+
                                          'goQFaIhtzEwzcxhnkNy6eYtNS2p1irwg6xBdGspNOEHxfjS50URkKLh3v5fstsWHoL4jT9B5wxnQ'+
                                          'PludegQmNoKLpIiEac7AN7qyQ4GEctc1VDamg0H4gAUekANOr7ou0YX3RrISadaeT6Q1IntyOgH1'+
                                          'vWHsbkIVdKecgTWNoBQem7Ex+/l4DACv/ZUMABYETjiuQGTHyTk9yzKg47ZYwkubiONQXPO5dIIU'+
                                          'Lihi3nPeTJJKDjY3FlwtzxMYR3LgdkN9niwdeI1bFBhIN24vqL+lAKT5vkVoRzBikWFhY6QlEJJE'+
                                          'H8Qvx8mKB4rNK+05v94Yf/77q/clvp8D4m/XxV+nW3Ov2SLr0WWwteFIcmEAwOZvu+aBFig6+Cnw'+
                                          'eECSjTq+Hye/GlUKOGh24vVsTBmDGrrtUh125Ik11nBSjrp+H01DBomOTMBSTrPXGvEBtPzuOiZ/'+
                                          '1Pj5qCmarmhj/Qrc+2bDmpgl5j43QZd5N37FM7YeS1GSYaQh2PMTWiKiyFRwT8qG3sCNOfLU9Vev'+
                                          'Y+jBpVrDa+pTHddKOIUyb7VE2qlKf4tJSJAZ703f5O1rqUnIoF7ah8lvoeFTDvUirERK9uMSC2nY'+
                                          '543P9sXrN2zapSIg/6kB4LnHH7MqbvTTofSzfcf2MBIf9Bzom12q6aDJBP1AZGeoe7CpRy0FLRKx'+
                                          'p2F4eOdIY9YP/3nPAOzh1ogypBvMfKqvWINzcQ69BqMYRl7qBQKM0qHJSN9UiXqpfKAAaD01afC9'+
                                          'tnCdsqoTNXjw0CxeTUa/jo3f/28COOLrIAhchkVngB3XQAwOBUVNneVMV0s9gjx5E4y5Q++oYRzm'+
                                          'Es6e/ITcZb4JTBENGOUTTiDQgPle54JcnWOdFcZGmu7YG6hvj3JgfIyiGI2G03MZDFAGiDhljdxe'+
                                          'P3Xt8f8IinhPMgoltZjEGEwZ2p5dEI7cqQC2CJE1pKBSa5cTs1O0XvfJRS/58LHfYz2dbfF+LREO'+
                                          'v+7iH8alcNJRlsrA4KUYcRpVifBuJQNVD8CmHY2GH0bEqWiCIidjqRczA1HpwLTetCUUjNF7CcQR'+
                                          'yH59WITEAXHuw9JY/2/7VQ4AV8QT/Z2LJheFGMnCosl4SsebMw/5psUgnAyTFTIWhiH63PoaGx+K'+
                                          'NvieWdfgsxFbn1LgsKMGCET1JkET817rFY59b7nQxyB1qksswSBpBTTcSgpRHHUy/g4LuBoANFo0'+
                                          'Qk38Pixum897aicyjObr4V85+f+9ILDHHnuEWet2l2IW5tFnOnH0UcRlFmfYmGM0u2z46IpjvdwX'+
                                          'Y5bk0LVZJlzpiGo0DI4ILBAVNYsyQGtxj4cDT/drtqkQLJAxGS3ZtP6oHAyLMMvSXHrdqLYmcV64'+
                                          'G9Ocj7QIlIKXQd/n7zXXgBg6ECZ3FF+/zwkJpgJoOtomc4GMXn+QcBFWYjnlF5u2a/ZxCLzFx+Pz'+
                                          'vIzy8kMfy4q/7+CvGhmiYu6pPFB2qdNefoJ2eDSbPgbO0oRIsmDcrIU/T2dBmi14cP5D3ftI5Lsg'+
                                          '6EnwtPDDTQ3CwsFb8fM8afP//7QAcMLxx1AhKNaCO6a3Wz2GRtzU1ilTDTY57h4beIJ2gkRSc+Qd'+
                                          'NhPSVQorsquOzYrFDCVg3Gw0zJA5THhDqebIvq5Ha2yOOUfpSZVHxA2JRdZcu2DovQjOzItE8sGt'+
                                          'wgndc2io7KZEFpEiLI0srO5fHb/u//PDi0FgVfw5p2NDW2Op13VmGCckyHoQ7DqOiqs5z9xqaBe8'+
                                          '0OcbHR1JHX9dFNDsp5Pexn69votmUEBEwhRqYkHREw0sALLGJ4gd6LmJKsZ1ZufV7ydxT9KnW94k'+
                                          'nUu4f3w9y7P5QGZdNzEB0fzFC2lEmMa0bYJ+dkwzI0SQmvW5P9aCTUCcAEQUXiOpC8Vg8tr4mtdZ'+
                                          'Oj0koMaeUY8aAEKNimBlkxdXna7i/lPp5ExIgbU03VEwERtQXX8LnvjPM4eGK/sSV9JLAK1Gs+Gl'+
                                          'QJHg6oUTiHIGoTfG0//fPUB26wCA67knHFsg9YcDDepBuAcD1AGjSETmqamtniZy40IAtOk1noFn'+
                                          'UtqUeXpUtyDRadNRB0EFklFa1JJYpq1V39CGCCQyr0CQkDglUVkc60hxRvxv85TvdLzBVEtADmx8'+
                                          'WkeXTUCdvkAc+nVGfICr/wMBYEn87eG4wJYAZ1AUpZgGAlDbT45qWq/0dbgT200EJAJ8av6eOaY0'+
                                          '40kEicpYUKw3lAJmPGpZVj/xFCSWigDUNdJQM5U/AyNKQcl3xK3bgy/e4C7A/dQ/oRxZzdiCjTrf'+
                                          'W3Cw0KbNm5MZieEw3CIeCFB9RmRGPQdQSTRTBCEeHhacPx7f8yfi9lsl8o0BkkZa5eRnyDJDen30'+
                                          'oSy1/YSdEJZDJYBlBj7ZoaQaG31ZzoyAdudsFube6FOjUeNF2/yeaZiGgI122ccyWbDArG1IleIn'+
                                          'bfz3nxoAnnP80atiND8dJ8T42IQtkp478ODGrV+/gSmmRmUYgzWJETecO353IVHgy5UqzadRYAnh'+
                                          'xOnGlLhB7YD5udThLa2WBqkBpcxAi88isnf5jSLqZqHWlDOV4L57yY25xBZhnlLYhSx5vG4DeeM/'+
                                          'ep/iZ7k8vsdrJDAiTLh6AcSqE8nX9imFzfu9s6/ehdFq3YzCNqrx5zumzdgx4FAtzZ+JkstsQ856'+
                                          'b0DAo6GTZhqiA0OdedZVmnFfgYDM+b2a0AwHbKiOeXNyYNLvHZuwdOASPT5q98g0DOu0y0ZwR6of'+
                                          'KiMwZBWjPh5Vt5X8kP7/096XgFlWVefuc+5cVV1VXd1NIyA0KCKDzGqcAgajqIlD9CWfqEBefOYZ'+
                                          'nz4kJhrNQxzy4sATMX4oJH5oouL0FPQZNE4xmiDiPKEgdIMMPU813Pmct/5/rbXPqerqttHQE721'+
                                          'qapb996699y91l7Dv/4/ymx5kc8RmIbmO10+y6PkMZ/OTRxGR3irRiVfiMVWrCCte6Ko/dAwIlw4'+
                                          'sy2pRo737TWLzKIRdyqetsUqvxmYK105k7AyO6VxbsOlzPh3LLoSZ/Z9Cf/v9x66v2tPOYBL67X6'+
                                          'G3DRKpZ74UKg4o/NtnXrFrYEt0/P8s1jd4LhlpRZHMRRiioN0/s8Eas1lZUmICWkRMzBScxKKlBM'+
                                          'xWWxF+t4AaeB1g8vY0jto6865abaAOwxG2R3YBN+uUlfMdRtaCW37TUH+6DNie1W7r/Yko2xWk6a'+
                                          'VU4yAoMn2s02s4aZqd/XTjJNB3hd5H0SmWjhpE/0dQwxWDVlX+cgQCg9MIYknwCcnFxKaS/Pn5Up'+
                                          'uSMp2xRTN87/c0ZAobuJsQ27AGrOuYkRFfOgnFrH6g1dNeqhTnMC0YeaBqIxRGgu3Y0x5z45IurK'+
                                          '4Wjy7HWj3cLQj0+BOs4Ce0E+06+tOuKh59y3Yd0l8llc4sKdeP0eLbjxFXJdWRSr1VA/WDoziDMB'+
                                          'iUUBjmCsGg+AS9dz6IwTjjpmDKTf0MhDSQ1uRVN3uu60XGGpmCqsxtck1/MBD//1auyB9egzTjlb'+
                                          'ci8IhhDV5fx+ilBrcdwXm2kj58hHIwYbJ89WQ9A5vnuWnl5DLGfg9aEQ5ZafVa1Bg8uGJLXBkEo8'+
                                          'EQv4azPyxQ+skq5hbGIAn2YJEFQ1uukuHYBXs729UxadlHW0GN+aX+daycZgFMBesE221etaIMXf'+
                                          '5KY0MtRgYJahQatRUK2aOCWjBUuXymAmReIN41ScIxV9cIa9f/kMeJ3lQdopULYdFG3nZnUy0BWG'+
                                          'MnYROkHb6pWopKTKyD1jtlWnNbCquwJsXCehS2eBCAaoQiXwHJrAiCIn8Xmg++Kqvyo5VsxKdLuR'+
                                          'OOS/HHnY4Z9Zu2H9/5Lv/zo3FSh+7iZq4nvL6wFODeb4gMQmS3WoqjaPIyC19rGLjmrU6PiQNBaX'+
                                          'NeQfxE5FZhgWvvfg7FAVY3vSSMb8TxwOCg9w9d/XHnEAWI8581QShOAER86IiwI1GgzywFuCk37D'+
                                          'hg0BsGGGRMMsioMo0kpfLkNuyo0XxSctELVp+NgoCIGdkWdoBu6tHm/3qP5cix84njN3vv9INJFH'+
                                          'rv/cmIdwSvZNE75C3cFBHAFVNh+Gk2vksb82ckued1Kef4sPGRFrjoGYXi/2/6lU1J4zfoKMG9Wl'+
                                          'pf1E7JnclkusEZGGkWPDPngPmnyNIyN8r6DWHoEDBn04NjycwfgSZbYxJ4oqPn43NqbOHJEYtAxJ'+
                                          'N1bXDgSmPZ1SDUYAuTEIenia5DP6jr/A34cmgqs2gS2aFXKqEfci5Dq1NhuuhesxqBL0DJ7rzqMO'+
                                          'P+IEvPd1mzZ8VPbF72PPMEoxTb+a8Qt4x8QN1jkN0xIBiPNEYPlgV6Va1Agc7OM0dKmxJKUGFMpN'+
                                          'QzFlQVcBXFWDm6vYiSNRrTjIlCZxrYLr1q7b8J9O/7XY2mMO4MzTT/mqnGBnB3LD9Q1bbhhtq2Yj'+
                                          '72Y7DbDNoJBNJRZVrTfOi+cJQywfVUXvfsxoqJZNTYVNkkuiWg8REmq+99Wb45TRufUs8ryVkV61'+
                                          'Em3WwCC+bEVBY6+uasJO8dRgwasdR199/tyq69fJfX+jD0+e8xrZwBci5069MJQXcl7qELpR8hpt'+
                                          'S44DY5qOvHNKz9W0E9NTG0Y0dhrhhNITVavQuA+q/VPLlvI5te1Z52ixswxRfERu2zatCr+e0+J3'+
                                          'nZ44VMqGqXITIqe+TRvi9WH0G055fGJS5+HzvChMEothaEzUFUIwTsNgI93aMuw4+y6FWvOYn2N/'+
                                          'yIt52RGHPuTD+HnD5o2fk/f4JLy21oixDPVUpMZrBwRZVQpRjvJeYCuzX6AGkVpFhiDUS+qFkIgX'+
                                          'kYPhF6KqcJ4beWseIyInK4GYCwFFZvBeJ2gYYa387efK6f+AgX/Ka086gEtlc7wBpzQ89pDCCvVY'+
                                          '4dfBlB69OsJ4INw4L0CgjRZOoDnfZIV7aByDc+wLj6IIJo9BPotN7BJc5K2zCTUzrIgFQLiq0mSd'+
                                          'SLWt4adeFUo02WSetqdShqk++x9KbSE4LmcIlvVG2QCX/ibXSl7Pc2Q/fBoRCv52WZJc2WnqGrUE'+
                                          'PZ0QprON1mjGgljFhmJqRtlFIlWHVYdAI1T2YuXlh4NEsXXp1FJeSw3lU86ss60I8IxBX+k8MNWX'+
                                          '5RG56XTvOav1s3RALq0F7QBFRrZZDOTpHhTfj+uGQanUohpy5+VaJK7a/Thwhf1hQ0F0CgOtPQBt'+
                                          'KMa1bXxsyanjS8ZB/Ztv2rJpjRjUxND0AVyinfMo/SIV4Ix+5uzUxQxAzUJ77+tzNiFJIudgCA4w'+
                                          '0oMkmKKP39/lxILRzA0NIcjx74EyVTkLFSc/axWTX+O8xxox/gcM+79w7UEHcPLZ8ia/CpFQFJQg'+
                                          'FQ1sALTx4P2WSKjpxSkIUwBK2o8FuLoi0uz0RoXae7YudKGy4Ab5NJlp/B6tRoaXqcI7AYMlgMUq'+
                                          'wTiZGELbYAZ7vJb7uVY9fsZj4ACccszBNlZ8KjuA+9X+W2yJ8U5iIhqbh1OBmWIanHm2bpu61+/H'+
                                          'sBIrNQirM8y4CKjn+FhsxVU1V9fQezudn1f7lXijw+vb7fQtRG8o4aohJ+smEKoSZh0V6uzp59kz'+
                                          '9aEOOjRW8K0YVwOcPa4XjKFh9RdsQXINgHrMIg8f0EEx08VdEd30rTAHZ6Njyx2NzEJ4x2ErD327'+
                                          'b+ZN27ZscK6+1IaJVJJcaydVw1nU6o14+vs1ZJsO6achJx0X4IxADgrzWgYrHqZBUZz0FeMAVAo7'+
                                          'vwbVWjX+Da9D5Qae8vRBDqg3igO4dE/Z5R5zAFiPPuOUXDH9Veaik5MTDNlVu73KwRG0iDj91VUS'+
                                          'TmwK5usG+aW3lg+y09NpMq0+F4MeeIyqwM5woztPvDLX9mL+6c5CTx8dDtF59r6Rg+aRIbhldFJt'+
                                          'oyN3IIhP2rHbUGyi39gBYImhf1U2xdmoZ/jcvE6taRWflFY2A+DvyduZ3m92uW4tKNaj8Cm+d6pu'+
                                          '6iLkyp2Pdp6fZJpbz0YIMacTKfulfHXVWtFV4WvAMFZDW6+IQHhS20AXnoN4Bok20EVRGnMjXrGp'+
                                          'STIOy++g6sSzltdd4ceaYysMWNOxdpgYnwgbN23Sx7Zaj1k6PvFLvPDts9OPFwf4Ke/B102JhynU'+
                                          'UFl3SUWO2oldq77NL1RK4jCKo0iL1l2ioTopvkIeVY3LNQBniMK+TI0g1Osgzv2QOueAAZO041Uz'+
                                          'jkHWpx7w3n957VEHcMZpj/qqeLuzyfc21zbMdKeYNEu1T00NuaHq8wE8hMkxDdutNzvIYk8Y+avy'+
                                          'q2s1nPp8NlLqVVxsakXA9WIXwA3DkYE6hpzHToGywgwixRPCRbw2GIwXbvhaKO7RjQ4gJ2f3/V8P'+
                                          'O2oVH5crPC2569672cpaunQpK9i+iZRSrMlahGLgKxFBVi4Conbi7TM/7Z2QBc8FIFA5Z2V7jhGX'+
                                          'qhjBOUOuu0XDbCtwyMgrkHIlaRpRb4O+jrbqiGyVPX04LtdUpLyV3B/RF96D4iYGTB2QsvmMh/If'+
                                          'KKjHmZedYMXJVlxCG3/LIq5PPOSQQy72Szc9O/M0iXre79OlKkaacbIwmPF5OzEkIV67CIpKi8hy'+
                                          'MCzYgn15KpGmmrN7m9jnA5QDQXEAqU2qKuBJi9UoertzcJFUHweWv/MBMf4HbPJvsbVnHcCpj7pI'+
                                          'PPjlinMeGEd/k+OluNg8nep1C91SG4TRnBanU2pDFBjphXfWcWBnbEkil1/fWINdh43VeoNucqZf'+
                                          'Qks/+cnPZ6CatiH8qF9nMmA9E+lgu7KrUtc6XtvQwRoTrHAm3t11AAsNvvR58N/da+/9bXmuL47Y'+
                                          'rIP2kzWHJ/JxdoankmLgVQkXBolcnxp/cFpk1lGwktN0p8ZKi0Kpsxf7GpCsNadjgQNAzl23OQTl'+
                                          '4utEYk88bmJcaw+zNs7bQi1AvsdrU6x7zRypskCRhdc6Fz42i/Bf23KYkqsWAiyOojFIN1uips7E'+
                                          'lA8y4Txtay9YtnTqm8ES8OnZ6YvkHhdleUG64YU4Z5UOiapPVwxnUak6k/QwjvkqrqJnkZJ2gdJK'+
                                          'oRpUMxIVXgu0WzGDYS3PPNPBJZ8Yrdicg1f9lVwmNbHQStyD8ssn37du/b/uSZvc0xHAqXLRv8fw'+
                                          'ER+sbDBsNHhUFO1ADopcD5OAIVFGmY5pCzpO3KvHAAp1e71IYZ0N9aQPBkGFOyD6rNsxWWzlbBtY'+
                                          '8VE5BpsFCxByS27QegStwBlxmMVyZOcB9PlxjhSb5lzRVlrcAbjB40Xkixi8bovoDJJ1mzYcJXn1'+
                                          'LaQiqzcikw2nHzEKPT3NQhyWypGN81TR4qdDlKvWpeja3H1bKcB7+t6aLZ3Yc7RdHk/FwKIgSFjq'+
                                          'jbrBVlt0dnAkOHnpACYm1OGCl1H+B84HXNfMZM3gIJVTIdEZjQrYcdBt2KYRHXEbcyw0zjGXV6JM'+
                                          'Z9IdGvqQqMRMsQEO8MIciFzHm1YuP+RFIU7Sh3xmbuZ98v5/l9RbzaKjMDD25oYNk2nEmZaov0NU'+
                                          'EnI0nxeCfTZjvny4FkgTwz1E2K+h/hwNmEQC0TSOUzvM3CcHKXHW7vyrnP4P6ODPYmuPOgCs0099'+
                                          '1Gp5w6t8Np/ElUOt6upk1giVf3BZndZZmV91qCfLlLO/QfHEJG52N06OC1uvm0y4ct+RVsv417Jo'+
                                          'tDo0o4XGroWWQyuaOTusglcGsTDknHBDk7zyto07paDswfGaLnLKR2MPpH/c4fYk989Fbr977X3b'+
                                          'vXiJqMXHn/GEXUP9efiK1+yTfliF5HViBSsDsxDj3uPp26gXg1De98dYqjq3htHb5UatpSxJoAR3'+
                                          'GPLAKuG4HiT1qCnugqQrnufK38JrB7IQDrnKCc+tOjdvIBkH80RhTuu8eGuzY042KjEZSawY5uuW'+
                                          'TS79FF+m2mGYmZu9Tp7jeA/LPbzuGZ6gUOGxtqrtn8yRltaWdmZpLaLW9KulmZT3SpXqq2cpCpqW'+
                                          'OaOJWizsBasfOOeEq7wUpCOVCEY77LDD//ibN33rA3vaHveCAzjpGjHeCxuo+s4oZ7s6/CyOgOoE'+
                                          'WCPmatrLz1hk6itJolJFoR/eMfpucSBoCWmIlhNGCvjnnBUAnUjEQzgs3WxDm3MvoLCe5zk/vpNO'+
                                          'RmrsoKeuz+Dr71Rw4uiHHkWiOCsIJmEXp3wojH7R2+5dt/azsk+egPpFYkzJSuJh6rSDfoT54mFQ'+
                                          'AEL0hNMKt0fGIKtzkEHYiDyG1ANYEjkNnRAVm5xIv0hr1TdFnx43t4OI4IjAy1gxRKA6gEJNyenY'+
                                          'UIxVyjNt+bkkOFq5HCoykRASvRKyq3UatCh9pl5rCBpFwClz+jHL7l2xbPnTjFbALlnI5zpzP2WN'+
                                          'xyvvxrM3oOGqE3BC2txCcedwcIGSsjIQnzlJo+xbxRR8uX9QLzIey2CFy0i8guuSJ7av83hY+Yh2'+
                                          'bi1KFJhnpmfWjDZHjsHjbr9zTR724NrjDuC0U056jni+T6Ovu2nTFqrJ6MSfT+INdcIK89MWPlE6'+
                                          'qtOxOXFtwaikco0tPpwS2CibNm22IQ2tKrsirPbB24XKi0USriPQ4PCNzr33+yaVJdEE8l2nm3Yx'+
                                          'SA8RNXStxPFgRxiuOuKh1d0xbrPM8m3KMGm34T5r16/7oNzydBiDM9/ouHDFKuhzbGXpiKoaGMJw'+
                                          'bXU2g/PsuVhmq6XXAad8oGTYEm5gL6zpmLTKjjfsGpF4Ex0UYwWeoRpzXT8D66EjhyXZh6VUTMds'+
                                          'rt0VoGsxWtHriNfh8wJONZ4aWxHbfqZWNDSZLKdCdzEWec9Xyen/Pjd8XM7eoHemGOf7nfWJhB2c'+
                                          '0KvEgmiNsxDKLDW0qdFmoxH3hkqTFbqDjqL094paCFuD1PkrZMODAcgo1krq+77BmLUtra1bfugm'+
                                          'cZ8YEI4MVP+11Rj5YGLvY086gb3hACbFm29psCc/E1asWEZZKUJqh1ZMkw+hTYBKbqOkozHX1NHL'+
                                          'SmzjbNi4iRsT+awOXDhTD8gktjBnTa2Q6C0vLN9UygvYiIouHVObHZhmuxduUNiCRgFONKfuMtLG'+
                                          'mDuaA2jcn1Nej4l5jqFcB3i1bLY/R64No2oTOVfTSUQr7sEBeYcDi9X7rduYSqEeMBrTgoSYCNB/'+
                                          'eduPuHO0MQfDKEbh1XiAd9Daq1shL60oQQs6A6Q8w9h1PlR9QnMMcB4RDovaQk8He7qcBlRtRy/a'+
                                          'IqJz5h1GfE3VeaBoq1OrW3sXXQ/Odsj70d55NjOxZPzZ4jS22bZiBC6f73nyuFc7bNc5+bRAnJhU'+
                                          'ejUCqLQemEZ6teC3J4XuH07pxIzWi30+W0CSz0oltgQ1TQxxWEuVpEOJ8TjEmoGT28h+u7NVbz1c'+
                                          '30Pi+WO+p5zAHncAWKeecuKnxes+B6f+OJSCt2wLYAwCww8YaUH04JDLPhVnx8J2+V2SK5ClZQo/'+
                                          '2LhbDcgCz+08+Y7bJ3uPVYJxO1stVqV1WewOc8+i6quadVlkzHUaqXZHZbKRy+Kk806BdwA8rTjq'+
                                          '8CNGdmb0ZuBp+ZQPO3MCctv6TRsvlpf7qqmppQS/FO9dSSr6lrI07b04WSbyaRg4kH1s/xkUdlIc'+
                                          'gCsTedvUtfg8v+bteB4bSmkafFhHV3ND79UtF+7H+3etlepcYo7EdBafQqVZ4bAOBEItAANfrqLj'+
                                          'OHyn2g6GacBB4KKfctsNUxOTbw6YfrIaHK69OMNLxPn8XjEclceR46Gdzkog0jMC9mLKlISsvYEp'+
                                          '/GhtAh8JoNBuJgOb/fCQ3pF+lZITcTZhqCJhSpWzI5ZDunal12WM+egl4gD+0d6DO4E9FgnsLQdw'+
                                          'oRjtNRUjUSCXHvJBU6jFz7iIQAfOWRV+O9mDFTkGcgkvxvQNcooLDYJKFQHRkxGY665hzD2vd856'+
                                          'bBAUtKyXHBlxhkZJpew73YgVyIwRGCEomWttDBYfbpcc9RoSHnn4EUt2y+jn/5y6E8hLEcLGzRsv'+
                                          'kpf8PxEBsO0H/IGJf5aJSZEGaJV/LrLh+nV0kkrH2deNwDQn6ckwzgfoFOVIlLCuVuoRr54otY52'+
                                          'BIaauw5LNNa4xm2DWNMQodMHtF7NhEbF+czMtvUcTlLjOKzTKaFlOWtcgV3WBgasrg9sAIf4i64S'+
                                          'pXYMNDQ2OvoCybvv0fMVF07TgH42+JQY40PwumtGzBqnE+39Y/LU1YpZ8GVdI7XPVf8mQV5MZZwE'+
                                          'Va9X15SUh4NBHByKbNGYcLSvieH7sVw4dGjF5bqxE+Xks2jf2ay3jktCdGL8lyRFWvNAO4G95QBW'+
                                          'yZtcrdJcdYI0VDW2+PADaapbPEmUGbhn2nBKOd2zGXZ8yM6k6+CcgfHGVU2XjidZpH3OSESKv+Uq'+
                                          't3AioLeC4aC95kMgfol8A1aM1409YZv6ohy5UVXjcUcedvhk8Jx+50av+X5h9At/5v22TW//LXmf'+
                                          '/+SahM7u41X/iunLO6W3IwIBwnGmG+c/8Gk4H3Wmqm+mRVcYHyDReJzKcff43FU7/VqmM1Cn9Hab'+
                                          'ITkLjaDbznXufcvmrXweP/073Z7luS065659Rgj9SWRqvIGOpmN9QSI/gofgoAh/7nmYHHTkmx2O'+
                                          '/1g6MfkG+QordgA+rtqYGO0N/MRSV/Yd0nHVLP/OjW6+DDRyqO9gWNCBa6HYBUHDfHIP71xYD59t'+
                                          'PUP05TbwA1yLsg355J/+PRdX4Vi7Us79UaPW+Iz8XUca7eAEDkgHgHXKySd8T4zyVJcNI+2V5P3g'+
                                          'nuPst1EnY6N4eEqWnorPY+emAtxjrodCGQzRT3jP3fs2pRentEKwVmCH0GOkCRT1wNRfTfv/Djel'+
                                          'FmGvbxV+n9iqRyw44caRXELlouUxpy2bXHr3r2H08WcbhEu2z0w/Vv72B1xAhCcT8mI7TdiGNLQd'+
                                          'dRFazUhy6c4gNzozb6ViKbBJdQHw3kgtbph76ABs2zbNfB8nvsuppUyXAO1tM18PZkBwFqjRqPJR'+
                                          'LUrA+WnasNkEJ85AKqVU5l3LekIE6nAwywwsmDqQE3I431+z3vgrSW/AsqyN/SRYfy1/otzvLR41'+
                                          '+FRkZsrNRIja56jUZEatZv1/FudMkESvkT4P6hz62ac2X5FZ339ocl6uLmx4knrNdCtCrGepUpMW'+
                                          'JRtWe5L38/VmrXluYBoTw/7i3x5KBfamA7hI0oDLFaKqzD0kaxADB3moynBlZlzBDExzOdyOybOh'+
                                          'nXDY/CjQAYKqtE1KMMmR1H4vstb4B+nsvuhPw/hRCEudu83wAdjQ+CDxgTqJpY8C++bWvZvH9hnC'+
                                          'dHnMcw9ZvvzG0km+MLxPd2H05Z/T6dmZR8v7ez+n/brKqjPnugnBGGQw8WiKOk5AERLXlM+KIRdL'+
                                          'ZdiLd/SkCa44Zx6IVR2plwQNX+FYEaJXakpX7lyE4G0gLZuRlfq0IScJg2MANMrqk1G3xip8bhp4'+
                                          'mr4NjOVIQV+Zje/CoTO9se4G+Q86GO4Kq+X0f5V8A4z2MAdzSEgyGkoa/kye63nqdJSYFE6v3+uZ'+
                                          'LkAlahd4/SgYEIfMwiGPaYdLlDmVV9N6+uSJyCysDyG2Blm/QKTIgbSaEX3oxGVikGGD+jIiQqom'+
                                          'f/rx9WrjB4sY/B6NAvamA1glG281J/FSZeStobre7hpXv8JLYczcsEliHHni+ntKc+XcfdjzuMhb'+
                                          'tmhROLMiHwt8JTCP87ElJiul1fxODPmVZsylvwcRGKQGVDEnpegwx4OX6cHIgV+tPX/FsmU3Bj39'+
                                          '01JRL13oBMpGn6tTMAfAn1MJE8+Uk/lqODfQYPF6kEZN1ZYbLkUWgp14A+UDtGIUBVgYrei8vyMe'+
                                          'dfBGJbpI1y0GjgKqpks9fo+THA5vxYrlxFJQHCUkSh0m15XEpSwKKoqwg+jM6LFpGPVCkahjEVbH'+
                                          'BFlVIHYQSU913DmNislO1c5wnUCdgcFva1eOjYx+Wf4urBcOYJBYIVDSuvdKivYw124k2CfTw8Kn'+
                                          '9Vz/QV9Tx8Q4CqxE36Yro2M3E3HpedUTCEZMohiAYKxDrtkQUwjjnfRCpEexgY6jd6UY/2vM4LMH'+
                                          'pQOgE3jUCZ8W43kOvseIMMA7mk/nodOTUBGKsLOz80Y0fcoN04JVE/1wvj9Vn+kqAoyRQFvhsbKp'+
                                          'm6SGqkQt9p4V+JwIomb67V0TLUUVXYtSChKqW+uPrDk2cWjIP3t9Q1O+SS4/dMUhl5dO99RD+h0N'+
                                          'fwcnkBbdgDyda8+dIZvsvdiwrs3nKsMNC89j5dkcH8g3qLXnQ02W6zdNR4CTfVYvYA9fnB2mHJGK'+
                                          'eT0FDoesTXJ/plZyTUAYimtJkhLDYQTSYudxZNfHWn0WoG+MPfhMiJ1PFJbrp7334Z1I1IdpaCT9'+
                                          'IrXR95htnByfeKX80QE5w+QlyDVCLpjJexqp1CqfVORiSmYdnuBpJRKIuuyYtzoH1sXwa+nqvT78'+
                                          '48rPiU0BOuoyNXCYUqT3iamomQqw8lRUYtFRr4d1G0xSXvbftkpSOUmuz9Zkfsif7Y00YG87gAur'+
                                          '6AawkNbjy0mNnx+tuJoVWRLj+lN6Zp295yhspRJnsDVkTFlZxkFarxVz8gpS0fbZcOCqMEoVRr49'+
                                          'O+ldlAGeHSecahLUo3Cjn27OSuOnlTLoDF3U8l0rly9/9yKnvZ/uaV50CdLyyU8HEIK3BNO5ztzp'+
                                          '8lre41oIechj9DKJU7rbtXaeItiCYfgJn7bTbNTCcwcxOTgoNapwnlJOlmkIuoaBcii22e9Fdh6c'+
                                          'o5yVsFO800F4rqrO7Gu3FJEZSJ6qEQYKhdOmYNw3SbhKpDVT5SXyB/b68Ron1mJLbbaBpBmVykdG'+
                                          'R0ZR5EPoMKADEJuGT5HHPbZaq/y1Mwr78jRS0Y9JpHfrG/273kcvd1bi8ndZOiICSfpS8AR4hFBx'+
                                          'PcC0ZOBGPAJHAB9V5wyHyZEjBQEeIw8vrFVZr+65AAAx9ElEQVRqn93Jie/FQFcxyR5oXMDedgDk'+
                                          'wpdNNZkYxBOnE/LvhhVgCL+s6ow5NkWn6xh4zV2rph+gZB0qLupEk1Xjdi+LgrjWvcqOzRID4GO2'+
                                          'jgtPTclGDaRqeIKa6fRlkQvQRTsVy961iny4SSKAF4X5p/8CJ2CpQb7Dya8OgR2EkMx25p4kr/9v'+
                                          'HLPg0lOk1hqfYCHTBVBdiRgFOmxCGB2M33X7SMgq94fhovaBNMeptJ3khM9j+H7XO4QDwEmK94/0'+
                                          'w6XI4BxQLESfvNvtc6M3TVxVuRfRfVD1Z6QMKuul6RZOxor9LXXefRWFtWJa3ZB5Pgwm95kbHxt7'+
                                          'rbyvbWb4dAAhaCQgkdGfyHt4lo8fR/TesAB3efqiofzAOCASHe/OtD3pghzEAlQqsSCZ2XRfbnWf'+
                                          'qrVRsXAg5VaU9RDfpdIcPIXrlyu24XP1Sv2FwU58M0AfEtiZAzhwIwCsk086/hrZXBd6OIvTGBsN'+
                                          'oWy72+bbVwLIvvX0tQil4eKAqTVQZkCT+UgsK9KNJqOAjunVA5QBXLvKYyuaT0UotfIc7BRw3Hia'+
                                          '6uAIrrpSgVXMUJRRBhtWZ78VROROQHbGLYcsX/HcEHZi3Due9ju930x79gLZnBc4Bx0ILtumOKxM'+
                                          'QVnk/VdmHM03MRTUsaEgp54CrwBSIhSq0PJEFID3pWrIlchPlxlIR0VWFOc+MOgqnMokMAkzsyQF'+
                                          'xVDPKKW3NUfXwZ0eT22V28oieMdP1NT66h5q43ZgBpRwdaBFWnYnepGbUAzrc5L7X2+GPz8CEDtv'+
                                          'NOvvlP1zNCMKG7ChQWcK/HJIMQ8MVu3zgsk3y2PXKLHKvYLFcqNQVzpwdQqGp6hpLz+12YqqyZa5'+
                                          'fqDTgDEVJfKQvInb0qRyioT/W3fTARz4KYA5gLPlwn5VaanqVBBGKDW+ZIJioo6aUpmuYB9mZgCT'+
                                          'XuwcKKLPedWUu89RZTrtpq0pJSOZjZDX3JCB5YENHwZB2O304/i7qANgk6HQBieiTDtagdc2mU4Z'+
                                          'rly+4sSdGP5OnUBeFArj97Nz7fPlHbyowbbW0OTUtyvZZLwuitLT9qWiAJXrjwMzUWYcjg/3yW1s'+
                                          't8HZ/XY84ZwWzCcOESW4EOeAlfHE5Ltakd1XwUOjVlz0fFtbj4rdnzHW5EFkTXKVZw4aDQZRKRhO'+
                                          'C9wADcPa4/dw6vIe2mOjY5fI65hWw08GLP4lGglUqukycVbvK5N6eJiempq0EqH05xFx0spInVYj'+
                                          'fFcnPLUQSQWmJInMv4r9z6PiDx9LQJR+r7iFLLaHveDHYvJQSVPl5mdV0to3ksK4s19VAzjgi4C+'+
                                          'HnXiI5EGrAJwR3UDOjyxHOffN+abekNPLbxsUjyjxw8GYVRge31j7qlHmm7WBRLlYstsiIeqv8b1'+
                                          'pz1m5avrRGaivOAUMMYYL2ixv47uAQZs5NTSQZWG4cg1jMSJIJv53JFma+0uDX9xJ+AtQtw/ldfw'+
                                          'QglLX4jWI04znLYwlmajbtRdynVHnn0M7YDMpNeLYTXw/HG02cZvE2PuGR1RnUOH81atnkKy0VwZ'+
                                          'hJSdqRe1CBTOksQ5eDg8FGr71glBSuGEGjBmH8nF6vUHkXnJQTfRqZPQpEWYNTUEO22rrbRxsn5e'+
                                          'IovPoepvJ/+gHAnIZ3GWRIAv1xRODZYovRDijD8va6IgoIENdeH3BDxVimlAH+1WJWEX6SjGg53e'+
                                          'CwcUHELTZMfxfWK4FMcfsP0n+9kOhbdX09rbSqf9wt5/9qDsApQcAIuBdWL/Va5rAnyB4gAoMz1Q'+
                                          '+SjXCsTSYZyKDnhUtQevYpUavnOohHxyIeLYy9BjkotiwlA+rOUrlnPIxfH0pLrudk3McRDZeNwQ'+
                                          'XUvALx9OymqtkJQWg7l4YmzJ1xY19p07AasXFN/Pdeb+Vr4/yVF/cGT+nmqmhts0dt6oIGQFrKG1'+
                                          'Pj0P1txbGXnVOSiZCMFLVi+BsftQTKOmrbS2OEbl9Z+LohdEVYKSrNuLo9YOiYZRcWbCCn/k3cf0'+
                                          'pPzs6E3nxu+Zs3L4bcdqQC5Kwjn5lYe+ZWZudn2iIT+qjUPiAOAQxOpGRlp/Kifxb6OLVHAgBLY+'+
                                          'lQJQ6cPqNaWSH1qaQcdgpJ6O/ONQl7V3c6MkykyAJRjGX1uK2gXwOROvBzh2wJGs1nn4l1paezEw'+
                                          'TeYAFob3i/28R/L/EPYdBxCLgXmeWg7ZoFFWqnWbI9diTbBTbMYGXZy/H6fFsmVLw6bNW5iLYiMr'+
                                          'PXaqk3EWnpc3GjY/QBkTE5M8fbwDkRk8FIg1VqVL6YRvDBfi6A8GUdLK2XckIrlacuV/CPFkL5/y'+
                                          'O574Whzc0QnMddpvlr90EjYwW0pB22g0UFc8tr5zzxyWF9mGdGRDOtRqVTcuKvIkE7VJNu/VIwpC'+
                                          'RECFHxtvHcrjloyPxdl+IgW7/chIpLJkIbZS4cZQE9GOQy0aNRwyXjc1F0KIcGp/nPMvcKbAxE/w'+
                                          '2RJnkSTfltz/owB0ImMIdvIjeEiUWTMdGW1eIs7+oZe+8c3hhz/4frjhhn/mewdAqUKgVIipoU70'+
                                          'DSJRSs2ITR1ajUvf7/VK04CpKfdoz9+Zo1192h2stwiVoVqvTa7IwlvFcV8gCcV6+QWQTCjUDPeV'+
                                          '8H+fcQBYJ51w3OVyUlyEDeI8+0pSEZhzo9VEmS7Oio9w1BebEacapgqHrDo3JETeFiaXTpGWGjmu'+
                                          'F5WwWLCxNECjh0EcGBmacVddH8BQW9pO09HSgbHy4nRFvQK3IxXA0NKWLVvpVJBDy0X92tKJydeE'+
                                          'YAY/P8c3BKDfnhuBiKYKRecgFwfQea+cRit8ICVyzhm81TsCWjVX3gIV99QagLbV+jTugRWvhjab'+
                                          'TloweRzadRXqAujYMDED5Khrh1F5HiLkWJzV4StGacapTyKPfj/22iNllk1tomiJTg4cjjL61k2R'+
                                          'SYeGBiZPnhgsFyd/1XDyyvY78jZJNzaw928OAIahyGQex5VWq/7u8cmp8Od/fnG49tqPhDtuv51/'+
                                          '789e/vLwmc98Jqy+446ogLRs+QpW5TdCiRiwaKOh5/BQtRa1+SIvwEBJYWOBeqg1hoZ3O4xsVCOP'+
                                          'agSN8e8N+nekefpKeZ0bxHG05Sv+YfKsjcuzSxDQHmj/7YsOYJWctKvrPKH77L1yqk8u+pR8wEBg'+
                                          'T0v+O6Qs1Sj57BmONlv0xm2twPPEVoabWaWmSgtBB4KGjC/fMfxeIGJbisq7owxXfUjFlWT6JfVY'+
                                          'hrCp5sxIPcDHx8Ki93pDfp84gOcvEu7HWkDJCUSHUHICdAidbudj+IRU3socVEVPYxgRahcg0KCD'+
                                          'sNYU3hP4+VW5KI3UZ3hvPZNYQ8TTZmtUaxYtkzonhTr4AmzGFtOSkGnvssgpO7ergqB4r03jI8Sp'+
                                          'OD2jOAgnDMWmQgEQxUiV7+7SGfvgDMBESrTZjcAfhWrr59HVQaLvjo6MftwLf3AAxEjLHaMDkI9B'+
                                          'PqHLTjnl1HDiiSeGj3/8YzwkHv+EJ4QLL/zj8M53XhZWr16jkltioO961xXhS1/6YvjEJz5BZ4q9'+
                                          'c/m73hWuuOJd4Uc/+pGJc5jenylPeVrhLEN0CJScU6AQrpM+rmEaABQZuVPOeegTbnTDl1/N8as5'+
                                          'gYCoZi+f/v5Z7TPrxBMecY04gAu1Ep+b/FeHXAH4ELZs3WbTbWj35dQGID0VCSqGUQNOwRi9iPKa'+
                                          'nW1bv7qrQhEhFFVhK2YpB7xuAK0Eq1gmi4fGS4BTYmjqsM4I49BQx5GTeUaMS9KHp8v95vJfeerH'+
                                          '0F8NXzEAqWyio+Xf3+K9wKHhNeUWtvYN9NS0aUndzDrW2+cJa12BmlJfOT2Xvv+KDQUpxDaxnB6O'+
                                          'Y3xiPMyIk4Uwi5Oe4n4dm6ZEB6Ja12gD79nz/+npbSwcNmxqENVvwqKRkthJSp1Hm09olV6r1ygQ'+
                                          'YY2wyLkNr6Uz2hp5j3zmG9wBoEWW6GJUzw9LMorZ9uxbzzjjTDr/X/ziNkaGL33pS8PSqalw5ZXv'+
                                          'YS0DzueMM88Mf/iHfxQ+9KEPhZ///Ba+zmc+8/fDM57xjPCGSy7Rv5srcQeusY8D122uwDkOs6GT'+
                                          'v9iknz3GmYTlGt+dDXMU/DbJS2270dMBpP59dAJDa/3tFePfFx3AqgTzAajSwpBmZg2jX4+kikYG'+
                                          'yRyYEmPZgCEZNh2mCYtilM4SjBqbUN1yZlX9bVmeqfBifk0VztskUagryCj3PFs/piWHRZ3CuTY3'+
                                          'vBpWJ+La4XAgoS2b6K/ltPz3xar7JYMvA4WK2+RnMawTxMm8HqdN1ULQSoRCpwToODtNlSmCEl8o'+
                                          'C04lSlC5xgFfn5FWlPnuAkU/tK9NR8oN3qdzUeozZeQlDFmun7a4KhF2TCEXGyoC4GVgykOZ5dbO'+
                                          '1OxCpQNDLTKqsvcAI7KKPzsAlbT61ZFW64shWLVfzgOx+JzGr9hcwBcr4NiYnp3538efcII4p200'+
                                          '4q3bpsMFF1wQbr/9F+G73/kOUz6MOj/zmb8XTpD7vfvdV9ABbd22PZx//vl0nB+45poosOp8Ci55'+
                                          'ruAhJQX1SEBTosxkwkNJzWi4Wg6ivxcD3+yGn5aMPjqDJAEZJnja+osV/g5oSrBftU44/lhGATi9'+
                                          'UcQj771ROiP8pBIPpbgaLNx5awb8dnAOnocjNMcJrYq4vcgyy+KUcenrgEk90mb71KDfz3Nm5K9O'+
                                          'Ie0z+WhXAoCDTd210VsUH12vTnbq/10yuuTK+eF9blDgeSF/stD44Sh6g/4fyJM+lwVAa53hNG00'+
                                          'G1GNhkU/u25VzjcUGogq3aVRpnPPOUbdxTA0glCaMZ99UfovJc6E2OeWbdtYQ2CLECSrwAlQU0+v'+
                                          'O0J9x2RQiackpOpzCk0bZ3bRjbZFJyjAApOQGbuROejO2Mjo/xHHPCNnYT9P1AmYog5Z9nD646NY'+
                                          'tWrVEes3bHilcglui5Hb4x73uHDbrbeGTZs20mDRTv6D5z6Xr/3fvvY1Xg9Eky8877xwy89+Fn76'+
                                          '05+YMWu70FulLgce5wOsVqBRYCXeT4lkhjfJwfEZD/nlsdHgU3xN5zmBWUsFVAVlfipwYHMC/qol'+
                                          'DoBkIVFpZZgZY5C28mqGIvO+LTEAFK6s0FBdKHNg7MFYJARptkoKsEpOqZxvCn7xaUAsDPxUDE7a'+
                                          'MIWgTrcTEWMOJHFoLsdJgffGUAgeDxXjEH4wPrbk1Ts5+RcW/eYZP37f7fdfKn/riazWEw6tGw2d'+
                                          'iY4NMrn6r6rs6NhysC4AoiIYGK4f2II7NuSUGMBFKbIrUSmJo8MhGHFKFqHARP3JSZ9bp0O1AUa1'+
                                          'Y4CqORByhn8ge3GiHH+4rccCpEqPd42V2CMDFAq9EOm1kw7rBHL6j7S+mCjhh1b/mQKE3B1AYuH/'+
                                          'bz3+cY+R6/pHN9zweb7uERY7s3DssQ8PayT312g6CRs3bQ5PeuITw7r168Oda9aYzHclnH766ZIO'+
                                          '/IzqRORENCyHswhpZFWJn7NLpCPdqdkMg+zD7b3e4HPyvm5FyJ+qgbfnnf7uDLQOMFuqBTiAZI8V'+
                                          '/Raufc4BYJ3wyGMvl3D1IoTTqP53212e8AjbSACKzd2hkbEaT7LIrg6tgG2YpJLAw0+rmjAZfOUD'+
                                          'I4uvseC6NNjQ8Pw4fbBZcUKhsJZauAeDw6e/WTaRFgZV6XVom8EhxBxkUm13DRflPhLGPvVX5vw7'+
                                          'OAK9vzzPm+Q9HFk37n6Qk7Q7yvU3tKq8zplr/3qUgh2zkXePuHzrezujkLaoKgZwyYwxN4kDRVhR'+
                                          '+7Cqwp5kxiWcVcNcOFefOCQJCVmHO3QgE5OT7L6ow25GxWIYjw8u+d8lj8OgH2m50fKV1751bHT0'+
                                          'PZIKzLDwp/k/whgUAIdi+mmMAsQBjE+Mj/3+s571P/7j379++FaJugCSQgpw9KpVYc2da8LSyQnu'+
                                          'A7BPH3fcI/gZ4n7O+3jssceGu+66KyACd7o3OC5HAupwWlrImyW5VfszRzZ+V5z/1+WOW+V1dcwB'+
                                          'tEuh/jyHIE8wmxbGr9jtvWj8Iey7DmBSXtrqWr06Cc8O6u+lsrngyUnjjDB4oOO3hOKCHLM/iPh+'+
                                          'rC6n1bpiwKMmIVaNkYNHD3Vj9/HeOHnpu71I5IjNqRXrQDUb0GMrAlBJI1ytR2mu57jZt3OCUFOM'+
                                          'VrN1vhjPhoUQ35IjgAOolIt/Pigk7+kD3nIi34XNPtAJeR5fckg1m1qMTDzNRlRAZg5uXHTKSR/Y'+
                                          'nmP9w+DROrJbCy7MmRmQBYahfHxd07ob6ElrQ1aEDMMZJ9bKA8jK4bII99uq24C+PId0rM0G56G1'+
                                          'F42m8Fxy/T8l1+zmoAY/yLXnDwfAaIAFs8SdQKhYKlA7/YwzHnfnmjvOldc0dfc992ldRD6TqaWT'+
                                          'rE3cdfe94ZhjjgnrJQJA1ANHtHnL1nDEEUeEtWvvkz2yxBh7Q1QBjuO/SWIzAKZWpMb/EzH8fxen'+
                                          'sF7u21Xj5792+V+alNp/mgrEVmBQ9N9eCfvLa590AFjHH3fsRbLxLsfpNU35aGW5VZ01/XBIIlKv'+
                                          'GxBoTmf4ux22//p9rRU0KBBZ5YdIbHtFPT31ACGHzXn1jrUUG4wa6PuNDcbJHJT/vh7z/YI3UIeG'+
                                          'BtYjRsiMdAWhshjUX0q+/OOdhPwLjd66BXkqf+t4yTdfi3aen/QsqPUH1q7UzVgzMRNPS0ZNyBPX'+
                                          'B4AXzPVrGqQ1E3d0jmfgSYj2pvEy4vE96igC3wDGpGZUDiJBiHEfaF+8r2lUmkQyDFdN8jl+RBq4'+
                                          'tnAw7Ab0tUbhHRMslz5H63R8bPzvklLhL7BV5pGApgLyNUu9GyB2Km++JhGB+Jx0iaRBvyO3P3lm'+
                                          'dq6FNEXhzTnz/c2bt9IxH7JiOa8XokIfZsJodbDPvPyVr88+a3m96+X9/VA+gx/Kj9OYypb79eRv'+
                                          'uwPomrF3iq+hbRiAObsdxo8PZLinq/07W/usA8B65CMe/j2JAk5NgiLZYMAwcjC7YjNSWabXt7HO'+
                                          'gbbIDFyCTVa1MN6XI91wOiLMR0jctPkCGC0LZ1ZIC4my3cKBUJCj1Yo89di0Q5scVOkoDRGdsRdG'+
                                          'p/JR6VWtZvP6UEL47Qj42dEBiIE+TXbdeeOmvVcxbHvfYLp4zTnn9xObd9D3pFGCGhauAfrwMDol'+
                                          'xcyNr7/P6+KFLR+gCSzWqRQbjALApkajKB5WTSsPthEBT0kSJcrRhkWa0Ww1jWUp2DBS3RCAOjmn'+
                                          '9FsqokE9Rhb+stBqtP5ervVtZvhF7z9nBBCBQDmNh7/H514VN1CFA0AJBkA9uV38WfWRci2Ok9f3'+
                                          'ULmeI/L9w1mDSNNI857rf7ic8NOXnPJr5caO7LE18vq3yGtcLd9vSohFSFCXgOH31ehRyJvnBDQa'+
                                          'QIgvWzZGBCFByE9Pt68Yfwj7vgM4TS7wd53kgYSSS8YoSUUcvM20I4+lgKZpATZs5r9peHfXAtQq'+
                                          'eMbTD4U6tBt1wq8dCSKIkzdmInK8WTUdpz9Cbsep+8gqacotJGYluVIxRSKEj+mHxQF8OOyI818s'+
                                          'Aki8ANgb9C+SzX36qBGm2o7l5sVpHUz5ttvrRfYjLDLwNJrGGqQ1Dw7aQLHHMPeppS6KdGyyAEac'+
                                          'wVDpuIZ9HZZxWW68d44js8aRRGWfvuES5kjhrvqFxAAY03JqlOmuv+hsuuQuNBTmkDUFojV/Mj42'+
                                          '9sFET/jBPCegp79HAsPgEQL5AJLcogFJBcQJyD+5vZpYm1Duj58rmmbxX6o/55GcJShQq9h0Ou9k'+
                                          'rTmG6MAyD/21yd+AEffta49RAKIBydoCHEBgZICThk4ATiE46GcfM/4Q9nEHAHHNar1yqWz8S3xg'+
                                          'g5N4kLeywtss+/E1A2IEG/QxYsahC31qVIATDYpDeGxus/PVOBasM98wamW77Vqhr6pRgXzK43Ki'+
                                          'tq3gSFYcA9bgdgzLOA4cTiJXB/AhcQAfCTuB+ob5hcF4H3kN75SUZTlaZAQcZbkJb+gAikckMPQJ'+
                                          'qitnrE34eDIRdcaLCANHdFOL9NsNUzJS1OPWrZBTa0XWG1w75PvNlhb3UCsYIZJQgTt0Kv2+E1xY'+
                                          'dyGLnIO+q73e4sZOafOojKt/n59jnrfHRkbfJa9vQ/B8H1X/4IM/dAixDhBsDNgM03UBMusSpom1'+
                                          'CA0nEDEDeu3jv0jEisflJVNMothI4oM7Q/1bCZ0PUxTt37sD8IiAKUFAiK+OwN7LfHqvfcXwS+93'+
                                          '31xlZd1qPf2KGPJZlVQn8tANaFLmuc9QHoo32KAzwHWbsMWI5M+oGbDXDUZdOAgb79WBjwppmxIj'+
                                          'idBBDqPJYpVfi2usUG9XOS2cyNy8pivnWnHBpKIYZhuwyCSnfzjaGnnNIkXAgiWo1PrD9/LYQ+R5'+
                                          'L69TprxmOgRdq3c0ePqjhYYc19ueM7MzpqmgKQ9IPVGMBHkHcl/06YnDR/hfq0U6MJz8M0ZtjvmK'+
                                          '3CxCNQAadGQcrDJhFRY6ORnYjpuHKQ9p2ceIjXBRTiwH+fgEY2KkGUgVvH0phv8vY6Og+krMuKzt'+
                                          'Zyd97kZXfF9wAQZD0SU7fO8EHz4z4OjBeOonxd5PzOB968WRXZvec+Mf+uuzaKBvjqAXgqUp6hz2'+
                                          'KrT3/q593QFAZTep1NOlchFvk9BzkuQYAOxYTxm56vJly/iRrlu3jgaNYg9Psk6bxS/duA2t9Ftb'+
                                          'LRghRbVWEq2s6iRara7z7yimFYXBPObCOi2ozEScHZidKUZKAR+1tMIcwF+GxScAF3UC/eHgLHk9'+
                                          '/x3vU/nmtGUWck1dNLLQ4R0URyeB67d8HPeHIwIMFs6vZRJmMF44DJfBHhq7Md4nUiJcE1UZbtO5'+
                                          'YMHxoHKPOgKusbL5dk0pV9lxqRkAZyIRw9gS1Se02ofNGIzGSU1ODNo05uycDuDI271HnNQ7LKfX'+
                                          'ELvI9zXc5+mfDI0KXEN/jQri6R8WdwI2Zx/v406BAO6izpc4JSJuL4/kZsbaM4yOwNIB5SaIt+/1'+
                                          'ib7fZO0XDgBfxQmcKhf0Zq/cOxnoHBltVeUW0QDD3Hrd6KY7Uf0H0tbdTjtSRmPzw9hRJ8AJVjPg'+
                                          'D05T7/NzPiDoZnYoLOWzYQwuLmGMQLqJlIeAIBxu8hwO4C8iFHgB+0/ZCQRLAXqD3p+JgZ+FcNml'+
                                          'v4em/zewXLph8t2ITMYYlWTWtkyocYDb+iaGgpMd/XFEBc4chHRFRUX6TKkSIiY15NfUPVfNBCsw'+
                                          'IuJy/TwYeM/4E/E2XFrMmXaxVPhC0YCZ6Qa6ghG7Lm2dthQn9jZxdHcVlf948he5fmkMONjpn6gB'+
                                          '5gudQJJo3h4WOIGkCOnz0v38lHd6rrzE1lP+XfH9/PsuJPPcgc13XzZ8X/uNAwh0Asn58qH+Q5UE'+
                                          'GUozTbkp8ghq4QmnmIp3ZMS062Rg29o5qluHTYsKvguQcFzYqK4zSxHIcGvag3AeOIGJwMMQzBIF'+
                                          'GwXD4QcLm51oAn+Hk2J5/uMlo2N/JTk8OOzzfEcn4NBge495IsbyQTlVR5FaVKkENDQYsIb+mgbV'+
                                          'lUpr23TsrfeNbIPjv66dKI5jmURHm7dsYZGU4qkSLbRtjgH1DlyfjjlK5zvAfSD8AQfRpSRZGqMM'+
                                          '5cHrxZ44IqwRQoGV2NPbphRkgURbVOPpRWdMafZq9Z/Hx5Z8NmhhrVzc85n/oUcFKASy+q90YF6U'+
                                          'W3jCl419McOf/7udG35ergPsyvDN0LMFP2PtF8Yfwn7mAPAvrSXni6H/vY9polAGsko1EM03Xa+v'+
                                          'atLOSomleWnHKvtE0Nn9qWrLpFDTxLn2rJ6WOMXkdvwN5L0OsqGxmGGSKThT6W4HKeG5qTaUpp8e'+
                                          'a41+XAy/J06gn+VZ3zTiI/NvyREk8nzHiBG9U/X9xiOqj+KdZD2u6SzAYMjIQ3UM+mwHwsDGUIwk'+
                                          'P8G45tlDHdhxMtURowFT7XrlrnMSEYppWp/e+QUHZrxRQ1Ee25K/j8KrHrIK6kHEgUjMpbZ1ElEH'+
                                          'j+A4ajZSTLafWVK6/XJqcvItgSF/NH70xosKv3UCzOgHsSCo0cE8Y96lE9jhRI+nf9nQFz/9d234'+
                                          '+124v9ja7xwAa0lViQSS5GqcvpATh6FiUEj143txdl4JL9qx5ZVb7t4xJte+iZCgBQbD5EAQ5caG'+
                                          'RhKqtQHFACiO3p2JosRSS0WG4Ytf/FJ4y1veEr7yla+wIDajpKH/b2xk5DoMKMr9umKwcAQ9eWxW'+
                                          'NnyPCOREfoHc9gK8/zox8jpmjGgARlcnX79i1vG6QKSJARVXzQVS0Yk64SQgtOIMt0pblURMuwNc'+
                                          'atZGVBLPadZEuhbNsJVZqVIvkOQsQbsl6uzSyMaEAqsz5vjoNJwCns9bj6r1oA5UoqI3Suq1RvPp'+
                                          'khMofp6fBoQyDXjilfV5J/wuwvydnOj6+2Tx03xXen0Lx3d5WfY3w/e1PzgA/OhoHn5FHzepJi+W'+
                                          'a3+1QzbLHHeq6qLc/dPTs8ELPkph3dcCFVpkskG9Mv3a17w2XHvtteG22241CG0eznz0o8M555wT'+
                                          'Lr/8chXhpKZdP3z5K18NV111FWfL69ZB+Nu3vpXP+7rX/RVlymEk9Vr9Gtno30kU/dWhI8jzrhgt'+
                                          'vmZFBMA6ABzTeySPP0Zn9g11SMNeQmQhxExRx4Azc4ruxFB4nE7kRKMLnwwDgESFKu8wqt3SkeFn'+
                                          '+dP1plN86USdD+44Jt7VgTBYFFOdkMTxY5/4cyNHRFExbn4P91XYdc5UiWsfGV8y/oUkxCLfcJ7B'+
                                          'l3ruelvuBUJqAc7L38tRwO44gflh/kInsDOJrqwk170wAthrEN7/rLWvOwDtzywSBeC2pBLOku8/'+
                                          'JoY+QZRXSRRimlLT/Uje6XqBVAMClRjpw6Yjjv8j13403HPPPeFlL3tZmJyc4GY+5ylPCS95yX8L'+
                                          'X/jCF8JV73uf0jzL81z2jssYbl988cU0TBjbOb9zTnjUySeH97///WGr5NwoyLWarbfL6biWwBAO'+
                                          'f+RwAvIv78jr6enO0fcmz3Fob9D/R2L/AfRpNCLnPAzHJwFh7JgOpDgIcvo5hTeTEq2h6YEXLAnB'+
                                          'Nd4+nYhs2ARkNXYHanb6Z5ZCIWKCkyvz+ivDkM6u6Phw3Rh3M+MPGBRREdiHjRzTIzHiBdA6TJJb'+
                                          'li+d+pug4X751J/nBJJY8PPUgEzAQ/t+vtEHB+4kO/y80zB+YZg/36h3qtV3IBm+r33WAWDtLA3A'+
                                          '7yKaKw2rJBC9SgzuSQTCYFY96PRZl2PBOvRSNSJIwnvlBG0Ycs2dxQUXXBiOe+Rx4W1vezuNRykn'+
                                          'KwzrQXrx+te/noaD53/auU/jKOn1138mfO+73+XzT00tC2effXa46aabwu233477bpX8/52AgRIS'+
                                          'GhIkzrCiNh1AnnU8CsAL6/S6F8ht53v7j4AfpDYSfrcdLitGyfqFqx8hNxcHhIugubiG6sBA9K0W'+
                                          '4s5vOFTee1wHgIfaUEUC65HJoPeNqw8Y+QHnHhp8TiIrjTHIOf4rfroDmNXQWYpCV0/bjBRzMY4A'+
                                          'bYnmc0snJl8hzzGNkL8MrgkFvDf+vOBrVvpaNvJybr8gl9/pz7tr5Pt9fr87a39wALuMAuLPSfY/'+
                                          '5OvrxBgnnNnFT5+GjaTiRGu3u8b7lttUoOLrjz766PA75zwlfP3rXw/f//73wrKpqbBx06Zw3nnn'+
                                          'hZUrDw0f/vCHwt2/vDtMLZvi9Niznv3ssHr16nDdddeZmm4nnHXW2eHee+8NP/nJj2Gc32o1Wp/1'+
                                          '4RD5E23YQg4nQJx51lZ5a93F7c7c5yQfH+N4MpmMWwZ9XqJCJ2TrrZLZFwYG0dS6jdciokGnA4hE'+
                                          'FNlaFOvoGd+/MhZhHgDOAj8vX75MjVL+1rTcv2GEIA2wBnOAR4t4WHCOdSua1kp6iwAaVUw4A23U'+
                                          'iqnmVAx+jNe9beu22MEYGxv7i5Fm646gxs5cvlTp99O93P8vfkfuNv5chPe7MPKweIgfc3vb+Lt2'+
                                          'BAdAfr87a592AFgxCsAPeur7697BCWRJtko26NvkhPk9nMqomHeNfUYfbmOobPXppnVOd+yWc889'+
                                          'N9x99z3hy1/+cjjqyIeSPfaUU08Lxx9/fLj55ptJHAnQEZCFT3vauTS+T37yk6qg2+uGRz7yeBor'+
                                          'HMPSiYkrxBjW2iBI29IARgGAv+aMANjXTiQ8f4ac/q/H6LG26Oo86fH9mCHsOGg0GERNvbYz+WSm'+
                                          'dxiHclQ2DIbrMlmcwYdhzynQB7UDOIg+25x6SjvVtxY6lU4MV4WyXZF4RFuNMPCeVfWJ7DMUpf9z'+
                                          'GXKvAchj3j05Pv5lO+EVXONOoKj6z3cG1gmIof9iof7uGf38vH9H4E4Ii0QAB7LRl9c+7wCwFkkF'+
                                          '/LUni0UHw3x4ttz3dbLpH58amk6554NBeLOoEOwqP6iyP1lCeIyIfuMb3wiHHfYQphBox51y6qlh'+
                                          '7dq14Zvf/GZYIacnwuVHPOIRzI2/dfPNfDGINA455BB+3bBhw/enJiY/ztM/dQfAk5+RgMT9bdQA'+
                                          '8Dh5DUs6vc51YmRjnI6DwTUVuz/D01lTmjFTzMGpi6W5uI74ugGOmoiKCqB2OCGJHr0r3vZNLalF'+
                                          '7Tw1VB/u6Zn6EtqKzotXYRF1OoKNtMMwElWFc3L/1yPmILfr4JGXkaReL9HU1fLLLClO8egAQpH3'+
                                          'z0PZhfmV/7LRZzsY9PzwfudGXwrnw+Jh/wGT2+/u2i8cANb9dQLyr9HPBhfIvrtYwucjtK0VYgjr'+
                                          'KsEqR9ZhSPuwhz2cJxdO+xXLlwdP0UE5vXnz5vDjH/84TE6Ok1ADcFuAbH7+85/jWZXmusMBovbE'+
                                          'kiXvk+dfnfLUjykAC4Fyz7ac2pr/yy/nuu0/zYbDl9bIW5BYrl01lqK2kX5K6D/SpHNAGtA09CHe'+
                                          'SdO4B/A6kQJwBt9GiBGao4WXWcuSIh92dZD/4zY8Ft0CoChxugOmWzGWHkQLrJkYTRg5FEhEGgpS'+
                                          'FdCVGROyqy0pcSbp2r64Ytnyy0IBpY1OIIm9/sR/N7B23SA6AU2Rhjuc8jsaeLnCH3bL6IvbH3RG'+
                                          'X177jQPAWpAO7LImYP8acvvIYNg/T0Ls58sH/mgHgddsUMUVf2Zm5sIhK1dy895yyy3h8MMfwpAZ'+
                                          'RgQ6KTDL3nHHHcz3VYa7FZaJk1izZg1Ddk8vGrXaFc1G8yfFbDgMHyOhCPsZ/nfd+MWIxsUB/LOc'+
                                          'pEtSY/ZFi61BMNEwSpX7kA9Gn1EUpKLNACCgNgeUUNGnQEW1RgwCcm84Ah/TdSVl3A+OROXPFJar'+
                                          '7cRJjjB7CO89/oHJrPVNHi0vSbM5lgCOgeAf5/23MV/55S+mli69uF6rTZeMvDxdV3YC6hyKwh98'+
                                          'z3y8/WKn/G5U68NBo9/l2q8cANaunABv2tERoJrVks06MsgGp8rmvFDu9WT51RIO2xizzoxVtTXs'+
                                          'nQmHrFjGjY8c+CGHHcbcHsNGU1OTrMAr/XaVv4fRyfPMyWl4RaNW/1HgjLjOhqPxAMOXO3TFqHwu'+
                                          'nNd+tj33HHFOfwMGIxhRIbahdyIBalWZdDmBOFTpbhhvpapjx47uM3htHMvFCeyMtgjrwfLTNtYk'+
                                          'D/kpn50FAobwnj30x0L6EGw6kMNIZvipzfVTGSjRIqFLormijjzwF1OTS18p1wMqI1kJo7/QCQzt'+
                                          '1C8P2KD9l5VBP4uE9uFXOIIQDob3u7X2OweA5d2BsKuUAKv4HeJ/7Oym3L81zIYrBsPhUyUqOEd+'+
                                          '+2TcAcY+bZp0E+NLuMGhqQfuOMW29xluA2ePXBoTcCqzRSP7kZz67xaDvdcYYnoYE80xKqonfl83'+
                                          'tb9OhYxvm5n5ihj+4cAOXH/99eHzn7+B7bthiYNeq/5DI+gsZK3Zy+91OfWY2mRezfj/yUlgjknn'+
                                          '7ucITgIhpmootJhCdI1d2BWSOAxv7xXvX0/5LLb4Ogag6lkBtWrTkw6RVj7G/DYx/pfD+JOFE3X8'+
                                          'Pub0euJ7JODz/Vb0Cz5Lb5X4nRh8CDuG9uGg0e/+2i8dgK9fwxHgH6poaAs05DENMbZl/eHgcbKB'+
                                          'HyOb/TFy+3HlS0M8e0cBOa5sa/9m5HT8N8nPb2g1mt8z0gqdE89p/ANr89my/ap9/zDX7Zwg+fZn'+
                                          'n/e854WnP/3p4eqrrw6/uO1WVvOR63PeIM8igQeiASoWGx+fy5JTDjtVaSpyGGCKUKIEKORMTS0l'+
                                          'sCc1kkvjKDAmX5vpT0J0BIhE0G2A3kLd6LoHw6FJa2kEQepzYxXGYzgjYLLa8v9bpyYn/1Su0/aS'+
                                          'kWdWmff5+vKMfTR+TNTlheHvMFobzBkkC4394Cn/G6392gH42kla4O9vp1iCYBRR9q+Wg0IqD9VO'+
                                          'r/NbsqEnJV043uC6oThckp/LSXyvnMw/42mW64bOrV+92EnvRp+XXtf07MxFEnFc9JKX/AlJPa68'+
                                          '8sqwdOkkhTZ++7efFF796r+g4CVoqzNjNkINwNtzYEnGz1Xj9kfdAMAhoBjhNDZu3MSORdd4/xER'+
                                          '+MmvSMEODRksuWRRsmLoBAuC06qMZHUS4ipizj8kUzL5/fqqvYDfyZ2+v2xy6V+Kg9oQitaet+Ti'+
                                          'fH1SMvIFt2Xzbt/R4P1DeND06PfEOiAcgK9FIgJ/j8Xti0cFZQPVIZ04qz+v0FisvOwWyn8jT0Jx'+
                                          'x/Ljyq8nbN665ROywR/3/Oc/n+Chb3/72+QdBPnG373nPewwvOIVL489f9Qp3vymNzEKeOMbL42g'+
                                          'H5CEoIUJ+nPM+cMxoMOxafPmMLV0GVNm1Cw4BUkegx7beh2bbqwaFbqnQdRiAB0adfHqUS3J5bDx'+
                                          'XHAAqgugWn8SgXxp5fLlbyXxpXLgAfpH9ttQDNb49+VIICvdZz7BxgKjd4PHfw4a/X/eOqAcgK95'+
                                          'jgD/3VVUMP/38x/nt+Vedypum2/4eTzlF3l86as9j3zZuHXzpyQff/xjH/vYcMcdt7MNh/bdkUce'+
                                          'FV784hcRTHTttR+VE3lJ2LB+Q3jc45/AOYUbb7wx/NM/fpAgIBTgVh19TLjsssvk3zvCt771LdYp'+
                                          'EPqv37CRswsN10RE6N/Qqj8wBVhk8BkoTyCKoFp8TEgpjoWuwtDEO1xU1QlH2yahLk7ig5Lzfyoh'+
                                          'Cy6JMNvltmcoTvV8nvEXBr/w38Ecfg+uA9IBlNduOIP4tZQm+G07/r54jrDY8+xo+HnMHkovK9m4'+
                                          'ZdN1SVp5wgknHB/uvPMu5uKbNm2S8P+scPLJJxOSfPsvbuNo79p16yh4ecopp4SPffSjFL6Ecd97'+
                                          '3zqJEl4R4ETe8Y63h1/edSenA8kJKGE86MPGjPADVX0o5QDeDANu2OmOWgCmDdHvV3FOlVDvGj26'+
                                          'y6eVBVUyZVHdJM99haRCtzkPfhohz5h/SBAFuADmPCM3Bp1yCuAn/0GD38PrgHcA5bUTZ1C+Drtj'+
                                          '8AvvUzyuuF/5uRZ73rBh88YPiR09c9VRR4V77r2Hhbt1ctI/5ZxzwspDD6WOvcqAVyQt2BJe9aqL'+
                                          'GJJffdVVNEowFq1duz686U1vJA/ge9/7XjHkEZOwKoA6I+Tly4kqBDkIlIs5BVirR3JOJTJRfAAi'+
                                          'BBQaEeqnqY4J4/EdG/jJVD7rR0vGxq6pVqqbafhpWREnbVsU4Ao4iAIWGruN7yrC76DR7731oHIA'+
                                          'C9f9cAjx+3zXxr7Y/Rfezsdum9n+wu3TM++FUaOQh8m+tevWc6IQLTZMFSLMR4iO3v1Tn/q7BPjc'+
                                          '+M0bWZUHfx+0+J797GfLyX9XuOlbN7F9CcPNTdbLxVFQJ4AQByr4mPlvUm4sYc3AIb1wDugYuJ4C'+
                                          'nqJjqD58zdgODB2JHD420mx9Z4EKTjs6gVCSw4IENpzAfMLM7MGGt9+X14PaASxcZYeA/yxwCvH2'+
                                          'sPjpXq7y7yoaiD9v3r7lxkF/eDJCduD5Ubk/7bTTGI7/8pe/ZM6+fXo2rFx5SDjxxJPC+vXr2BXA'+
                                          'tCBFMI8+Opx00knhlp/+hLMKQAly9Ne498l/QCmzYHJdPT3xU6XHB96AGQooz0dHWBMgjNhVjpXY'+
                                          'lMZfSSs3SpTyBfm6lQaeqvGX9O86JRmsshMoJLCLU/9gqL+PrIMO4FesklPA2pljiL9b5Pud3jYz'+
                                          'NzPZHwz+RU7ZU2CY0LA77rjjWGEHRh/RAWnPly8PRx55JPXuAdkFIAhDS4dKqvCwY44Jt956qw3q'+
                                          'tFgbQF4PYx4zKfG+SXP3mBIoKYqDipxRyVt8yP2VHCRzcczv12v1L8n91rnslTy2LIa5UBizJIfF'+
                                          'FGC4P5JlPljWQQfwG6wFzgGrHA2EBd2DRdf22WngDS4Rg3klJLJRtAPSsEFl4DopuUF7DmNft26t'+
                                          'sfhUwoaNmyn+ecThh4fb77idoT6q+eQFNHQeBofAbOw6CAAKwSkA8ANqMaoINxpRz9BVgQnySdLv'+
                                          '1Wu1L0n6sN6EMOO/tDD6xf55HaBjJJ8Hi3v78DroAPbQWsRZzFtbprcd3e/1L5WQ/cVA92GKzzUM'+
                                          'AdVduXIlxow53ovawKbNWxjiIzq47957Cfut1+V3DRXc1L5+P8qlYzGUJ8RYR4rbHuIbHZiY6r3i'+
                                          'YL4thn+zfN1uApgACagSLucbknnOoCyKmWr1nwNQYOk9aPT7/jroAPahBScxPTuzTAz1uWKNzxaj'+
                                          'eqLY5cRWCfs57FOrksyDc/sS1kP2Cyc4iobLl02xBcipxIEKd0SVXocvB2UIzvxnlei+TU77H0i0'+
                                          '8MNqWoE+38AMHzS/fYhe4vuSEm5vvgOw6CBERzA4aPj7zzroAPbBdcxRRwEsBBXbxlx37nQ5xU+R'+
                                          'SGBVq9l8QrVWBeXZ8bifa/Ghbad0XSGqIIcFRm9Y/TXymw3y+DvlhP+ZGPxd8nU2FAq4w+Dad9ER'+
                                          '0An0bcKRWnhm6D3epmq4iBIGd9x550HD38/WQQewj69jjjyKk4xiwDWxLkwj1fH9MBtODYaDk4LK'+
                                          'XVcwBEinoRTjFZ1hoChpImH/GjH0uWIQmf81tJ0N7ZRHco2eyww+quFqVECj75sS7uCOu+7M9vY1'+
                                          'Orh+/XXQAexHS5wBpxnV2PNqjqlG/Vo1o9ff6fcmREo0YplLEcvhCYU0lg7uOBdfwdeXRKluF/AY'+
                                          'itEfPOkPkHXQAezny5yCqw6bynDxL58/3FSsxdRwFxndPWjsB/Y66AAeJGthF+Jgoe7gwvr/ZXkB'+
                                          'tghVDbwAAAAASUVORK5CYII=';
  EOF

  Preview.create(title:"Cellular", html: html_text, js: js_text, css:"body{
  margin: 0;
  overflow: hidden;
}

canvas{
  width: 100%;
  height: 100%;
  }")

html_text = <<-EOF
  <script src="http://zreference.com/libs/quick-shader.min.js"></script>
  <div id="frame"></div>

  <script id="shader" type="x-shader/x-fragment">

  #define NUM 8

  float rand(vec2 co){
    return fract(sin(dot(co.xy, vec2(12.9891,78.233))) * 43754.6453);
  }

  float ting(float i, vec2 uv, vec2 loc){
    return smoothstep(0.1, 0.7 + i / 20.0, 1. - atan(distance(uv, loc + vec2(0.2, 0.0))) * 3.);
  }

  void main(void) {
    vec2 uv = gl_FragCoord.xy / resolution.xy;

    uv.y /= resolution.x / resolution.y;

    uv.y -= max(0.0,(resolution.y - resolution.x) / resolution.y);

    float cl = 0.0;
    float dl = 0.0;
    float v = 2. - smoothstep(0.0, 1.0, 1.0 - (distance(uv, vec2(0.5, 0.5)))) * 2.;

    float t = cos(time);

    for (int i = 0; i < NUM; i++){
      float fi = float(i);
      float ty = rand(vec2(fi, 0.9));
      float tx = 0.1 * fi - 0.1 + 0.03 * cos(time + fi);
      float tcos = cos(time * float(i - NUM / 2) * 0.3);
      float tin = ting(fi * 1.2 * tcos, uv, vec2(tx, ty));

      if (tin > cl) {
        cl += smoothstep(cl, 1.2, tin);
      }

      tin = ting(fi * 1.1 * tcos, uv, vec2(tx + 0.01, ty + 0.01));

      if (tin > dl) {
        dl += smoothstep(dl, 1.1, tin);
      }
    }


    cl = sin(acos(cl - 0.2));
    dl = sin(acos(dl - 0.2));

    float j = sin(5.0 * smoothstep(0.3, 1.2, dl));

    cl = max(cl , j * 1.2);
    cl += rand(gl_FragCoord.xy + time) * 0.14;
    cl -= v * 0.6;

    gl_FragColor = vec4(cl * 1.44, (cl + dl) / 2.3, cl * 0.9, 1.0);
  }

  </script>
EOF

js_text = <<-EOF
  var q = new QuickShader({
  shader: document.getElementById('shader').textContent,
  width: window.innerWidth,
  height: window.innerWidth,
  parentNode: '#frame'
  });

  q.start();

  var resize = function() {
    q.size(window.innerWidth, window.innerHeight);
    };

    window.addEventListener('resize', resize);
    resize();
EOF

Preview.create(title:"Quick Shader", html: html_text, js: js_text, css:"* {
margin:  0;
padding: 0;
}

body {
  background: #333;
  color: white;
  overflow: hidden;
}

#frame {
position: absolute;
}")


js_text = <<-EOF
var pos = {
  w: $('html').outerWidth(),
  h: $('html').outerHeight(),
  cx: $('html').outerWidth() /2,
  cy: $('html').outerHeight()/2
}
var canvas = document.getElementById('canvas');
$(canvas).attr('width',pos.w);
$(canvas).attr('height',pos.h);

var ctx = canvas.getContext("2d");
var offset_inc = 1;
var offset = 1 ;
var
hW = pos.w / 2,
hH = pos.h / 2;
var rotate_inc =0;
function render(){
  ctx.restore();
  ctx.fillStyle = 'rgba(0,0,0,0.03)';
  ctx.fillRect(0,0,pos.w,pos.h);

  ctx.save();
  ctx.translate(hW,hH);
  ctx.rotate(rotate_inc+=0.01);
  ctx.translate(-hW,-hH);


  if(offset<=5)  { offset=5; offset_inc=0.5; }
    if(offset>=50)  { offset=49; offset_inc=-0.5; }
      offset =  offset + (offset/(offset_inc>0? 50 : 5))*offset_inc;

      for(var i=0; i<360;i+=10) {
        for(var rad=50; rad<hW;rad+=offset*2) {
          ctx.fillStyle = 'hsla('+(i/hW)*180+',100%,50%,1)';
          ctx.fillRect(
          (Math.sin(i)*rad + pos.cx),
          (Math.cos(i)*rad + pos.cy),
          2,
          2);
        }
      }

      setTimeout(render,20);

    }
    render();
EOF

css_text = <<-EOF
html {
  width:100%;
  height:100%;
  body {
    background-color:#000;
    width:100%;
    height:100%;
    canvas {
      background-color:#000;
      bottom:0;
      left:0;
      right:0;
      top:0;
      position:absolute;
    }
  }
}
EOF

Preview.create(title: twirly, html:"<canvas id='canvas'></canvas>",
  css: css_text, js: js_text)


js_text = <<-EOF
var C = document.createElement('canvas');
var c = C.getContext('2d');

C.width = 200; C.height = 200;
document.body.appendChild(C);

var particles = [];
for(var i = 3000; i--; particles.push([
  Math.random() * Math.PI * 1,
  Math.random() * Math.PI * 1,
  [
    Math.random() * 256 | 0,
    Math.random() * 256 | 0,
    Math.random() * 256 | 0
  ]
  ]));

  (function render() {
    c.setTransform(1, 0, 0, 1, 0, 0);
    c.scale(C.width/2, C.height/2);
    c.translate(1, 1);

    c.globalCompositeOperation = 'source-over';
    c.fillStyle = 'rgba(0, 0, 0, .5)';
    c.fillRect(-12, -2, 20, 4);

    var x, y, z, w, t, p, r = .7, f = 1;
    c.globalCompositeOperation = 'lighter';

    for(var i = 0; p = particles[i++];) {
      t = Date.now() / 8000 * (i%1 ? 1 : -1);
      x = r * Math.sin(p[0] + t) * Math.cos(p[1] + t);
      y = r * Math.cos(p[0] + t);
      z = r * Math.sin(p[0] + t) * Math.sin(p[1] + t);
      w = f / (f - z);
      c.beginPath(); c.arc(x*w, y*w, w/100, 0, 2*Math.PI);
      c.fillStyle = 'rgba(' + p[2] + ', ' + w/4 + ')';
      c.fill();
    }

    requestAnimationFrame(render);
    })();
EOF

css_text = <<-EOF
* {
  margin: 0 auto;
  padding: 0;
}

html, body {
  width: 100%;
  height: 100%;
}

html {
  display: table;
  border-spacing: 0;
}

body {
  display: table-cell;
  vertical-align: middle;
  text-align: center;
  background: transparent;
}

canvas{
  transform:rotate(45deg);
  border-radius:50%;
  box-shadow:20px 2px  40px #111;
}

.bg {
  background: radial-gradient(circle, #000 40%, DeepPink  100%);
}

div {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
}
EOF

Preview.create(title:"Blackhole Sphere", html:"<div class='bg'></div>",
  css: css_text, js: js_text)


html_text = <<-EOF
  <script src="http://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.3.0/snap.svg-min.js"> </script>
  <div class="centered">
  <svg width="300px" height="94px" viewBox="0 0 300 94" version="1.1" xmlns="http://www.w3.org/2000/svg"
  preserveAspectRatio="xMinYMin meet">
  <clipPath id="logoPath">
  <circle id="O-1" cx="93" cy="47" r="47"></circle>
  <circle id="O-2" cx="253" cy="47" r="47"></circle>
  <path d="M5.85352353e-15,93 L45,93 L45,83.3467344 L8.95275853,1 L5.85352353e-15,1.00000004 L5.85352353e-15,93 Z"
  id="L"></path>
  <path d="M146,93 L201,93 L201,64.0857143 L187.904762,43.0571429 C187.904762,43.0571429 190.492121,37.8636081 191.7858,35.2668407 C193.111168,32.6064652 195.761905,27.2857143 195.761905,27.2857143 L195.761905,1 L146,1 L146,93 Z"
  id="B"></path>
  </clipPath>
  <image id="svg-image" clip-path="url(#logoPath)" width="1337px" height="94px" xlink:href="http://kollectiv.org/files/strip.jpg"></image>
  </svg>
  <h1>COMING SOON</h1>
  </div>
EOF

css_text = <<-EOF
  @import url(http://fonts.googleapis.com/css?family=Roboto:100);
  html {
    height: 100%;
  }

  body {
    background-color: #111;
    color: #f14949;
    font-family: Roboto, sans-serif;
    font-weight: 100;
    height: 100%;
  }

  .centered {
    text-align: center;
    position: relative;
    top: 50%;
    transform: translateY(-50%);
  }

  h1 {
    font-size: 40px;
  }
EOF

js_text = <<-EOF
function animate(type) {
  Snap.select('#svg-image').animate({x: (type == 'reverse' ? 0 : -1037)}, 12000, function () {
    setTimeout(function () {
      animate(type == 'reverse' ? '' : 'reverse');
      }, 1000);
      });
    }
    animate();
EOF

Preview.create(title:"Nifty Logo", js: js_text, css: css_text, html: html_text)

html_text = <<-EOF
  <div class='wrap'>
  <div class='cube'>
  <canvas class='side'></canvas>
  <canvas class='side'></canvas>
  <canvas class='side'></canvas>
  <canvas class='side'></canvas>
  <canvas class='side'></canvas>
  <canvas class='side'></canvas>
  </div>
  </div>
EOF

css_text = <<-EOF
  * {
    box-sizing: border-box;
  }

  html, body, .wrap {
    height: 100%;
  }

  body {
    background: black;
    overflow: hidden;
  }

  .wrap {
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
    -webkit-perspective: 2000px;
    perspective: 2000px;
  }

  .cube {
    -webkit-transform-style: preserve-3d;
    transform-style: preserve-3d;
    position: relative;
    top: 50%;
    left: 50%;
    width: 300px;
    height: 300px;
    margin-left: -150px;
    margin-top: -150px;
    -webkit-animation: rotate 18s infinite linear;
    animation: rotate 18s infinite linear;
  }

  .side {
    position: absolute;
    height: inherit;
    width: inherit;
    opacity: .8;
    border: 1px solid #111;
    cursor: none;
  }

  .side:nth-child(1) {
    -webkit-transform: rotateX(90deg) translateZ(150px);
    transform: rotateX(90deg) translateZ(150px);
  }

  .side:nth-child(2) {
    -webkit-transform: translateZ(150px);
    transform: translateZ(150px);
  }

  .side:nth-child(3) {
    -webkit-transform: rotateY(180deg) translateZ(150px);
    transform: rotateY(180deg) translateZ(150px);
  }

  .side:nth-child(4) {
    -webkit-transform: rotateY(90deg) translateZ(150px);
    transform: rotateY(90deg) translateZ(150px);
  }

  .side:nth-child(5) {
    -webkit-transform: rotateY(-90deg) translateZ(150px);
    transform: rotateY(-90deg) translateZ(150px);
  }

  .side:nth-child(6) {
    -webkit-transform: rotateX(-90deg) translateZ(150px);
    transform: rotateX(-90deg) translateZ(150px);
  }

  @-webkit-keyframes rotate {
    100% {
      -webkit-transform: rotateX(360deg) rotateY(360deg);
      transform: rotateX(360deg) rotateY(360deg);
    }
  }

  @keyframes rotate {
    100% {
      -webkit-transform: rotateX(360deg) rotateY(360deg);
      transform: rotateX(360deg) rotateY(360deg);
    }
  }
EOF

js_text = <<-EOF
window.requestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame;

var canvases = document.querySelectorAll(".side");
var sides = canvases.length;
var size = 300;
var particles = [];
var particleIndex = 0;
var maxParticles = 100;
var hue = 0;
var mouseX, mouseY;

function Particle(ctx){
  this.ctx = ctx;
  this.size = this.random(10);
  this.x = mouseX || size / 2 - this.size / 2;
  this.y = mouseY || size / 2 - this.size / 2;
  this.color = "hsla(" + hue + ", 100%, 50%, .8)";
  this.maxLife = this.random(40);
  this.life = 0;
  this.vx = this.random(-3, 3);
  this.vy = this.random(-3, 3);
  this.index = particleIndex;
  particles[particleIndex] = this;
  particleIndex++;
}

Particle.prototype = {

  constructor: Particle,

  draw: function(){
    var ctx = this.ctx;
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.size, this.size);
    this.update();
  },

  update: function(){
    if (this.life >= this.maxLife) {
      particles[this.index].reset();
    }
    this.x += this.vx;
    this.y += this.vy;
    this.life++;
  },

  reset: function(){
    this.size = this.random(10);
    this.x = mouseX || size / 2 - this.size / 2;
    this.y = mouseY || size / 2 - this.size / 2;
    this.color = "hsla(" + hue + ", 100%, 50%, .8)";
    this.life = 0;
    this.vx = this.random(-3, 3);
    this.vy = this.random(-3, 3);
  },

  random: function(){
    var min = arguments.length == 1 ? 0 : arguments[0];
    var max = arguments.length == 1 ? arguments[0] : arguments[1];
    return Math.random() * (max - min) + min;
  }

  };


  function setup(){
    for(var i = 0; i < sides; i++) {
      var canvas = canvases[i];
      canvas.width = size;
      canvas.height = size;
      var ctx = canvas.getContext("2d");
      for(var x = 0; x < maxParticles; x++) {
        particles.push(new Particle(ctx));
      }

      canvas.addEventListener("mousemove", function(e) {
        mouseX = e.offsetX;
        mouseY = e.offsetY;
        });

        canvas.addEventListener("mouseleave", function(e) {
          mouseX = null;
          mouseY = null;
          });

        }
      }

      function animate(){
        for(var i = 0; i < sides; i++) {
          var canvas = canvases[i]
          var ctx = canvas.getContext("2d");
          ctx.fillStyle = "rgba(0,0,0,.1)";
          ctx.fillRect(0, 0, size, size);
        }

        for(var i in particles) {
          particles[i].draw();
        }

        hue += .3;
        window.requestAnimationFrame(animate);
      }

      setup();
      animate();
EOF

Preview.create(title:"Cube Form", css: css_text, js: js_text, html: html_text)
