import { Group, BackSide, AdditiveBlending, Scene, PerspectiveCamera, WebGLRenderer, Mesh, SphereGeometry, MeshBasicMaterial, TextureLoader, ShaderMaterial } from "three";
import vertexShader from './shaders/vertex.glsl'
import fragmentShader from './shaders/fragment.glsl'
import atmosphereVertexShader from './shaders/atmosphereVertex.glsl'
import atmosphereFragmentShader from './shaders/atmosphereFragment.glsl'
import gsap from 'gsap'

const scene = new Scene()
const camera = new PerspectiveCamera(
  75,
  innerWidth / innerHeight,
  0.1,
  1000
)

const renderer = new WebGLRenderer({
  antialias: true,
  alpha: true
})

renderer.setSize(innerWidth, innerHeight)
renderer.setPixelRatio(window.devicePixelRatio)
renderer.setClearColor(0x000000, 0);
document.body.appendChild(renderer.domElement)

const sphere = new Mesh(new SphereGeometry(5, 50, 50), new ShaderMaterial({
  vertexShader,
  fragmentShader,
  uniforms: {
    globeTexture: {
      value: new TextureLoader().load('./assets/globe.jpg')
    }
  }
}))

scene.add(sphere)

const atmosphere = new Mesh(new SphereGeometry(5, 50, 50), new ShaderMaterial({
  vertexShader: atmosphereVertexShader,
  fragmentShader: atmosphereFragmentShader,
  blending: AdditiveBlending,
  side: BackSide
}))

atmosphere.scale.set(1.2, 1.2, 1.2)

scene.add(atmosphere)

const group = new Group()
group.add(sphere)
scene.add(group)

camera.position.z = 10
/* 
const delta = 6

const mouse = {
  x: undefined,
  y: undefined
}
let startX;
let startY;


addEventListener('mousedown', function (event) {
  startX = event.pageX;
  startY = event.pageY;
});

addEventListener('mouseup', function (event) {
  const diffX = Math.abs(event.pageX - startX);
  const diffY = Math.abs(event.pageY - startY);

  if (!(diffX < delta && diffY < delta)) {
    mouse.x = (diffX / innerWidth) * 2
    mouse.y = (diffY / innerHeight) * 2
    console.log(mouse)
  }
}); */


/* addEventListener('mousemove', (event) => {
  mouse.x = (event.clientX / innerWidth) * 2 - 1
  mouse.y = (event.clientY / innerHeight) * 2 + 1
}) */

let animate = () => {
  requestAnimationFrame(animate)
  renderer.render(scene, camera)
  sphere.rotation.y += 0.002
  /* gsap.to(group.rotation, {
    x: mouse.y > 0.5 ? mouse.y : 0,
    y: mouse.x > 0.5 ? mouse.x : 0,
    duration: 0.1
  }) */
}

animate()

