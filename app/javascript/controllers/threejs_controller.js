/* eslint-disable prettier/prettier */
/* eslint-disable no-unused-vars */
/* eslint-disable no-use-before-define */
/* eslint-disable no-unused-expressions */
/* eslint-disable max-classes-per-file */
/* eslint-disable prettier/prettier */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable no-console */
/* eslint-disable no-undef */
/* eslint-disable class-methods-use-this */
/* eslint-disable prettier/prettier */
import { Controller } from "@hotwired/stimulus"
import * as THREE from "three"
// import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js"

// Connects to data-controller="threejs"
export default class extends Controller {
    connect() {
        console.log("Connected to the threeJS controller")

        this.scene = new THREE.Scene()
        this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
        )

        this.renderer = new THREE.WebGLRenderer({ antialias: true })
        this.renderer.setSize(window.innerWidth, window.innerHeight)
        document.body.appendChild(this.renderer.domElement)

        const red = 0xff4500
        const green = 0x00ff00
        const blue = 0x0045ff
        const grey = 0x808080

        this.geometry = new THREE.BoxGeometry(1, 1, 1)
        this.material = new THREE.MeshStandardMaterial({
        color: red,
        wireframe: false,
        })

        this.originCube = this.createCube(0, 0, 0)
        this.offsetCube = this.createCube(6, 4, -5)

        this.pointLight = new THREE.PointLight(0xffffff)
        this.pointLight.position.set(8, 5, -5)

        this.lightHelper = new THREE.PointLightHelper(this.pointLight)
        // this.gridHelper = new THREE.GridHelper(100, 100)

        this.scene.add(
            this.lightHelper,
            // this.gridHelper,
            this.originCube,
            this.offsetCube,
            this.pointLight
        )

        const backgroundTexture = new THREE.TextureLoader().load(
            "/assets/nuit.jpg"
        )
        this.scene.background = backgroundTexture

        this.camera.position.z = 5
        // this.controls = new OrbitControls(this.camera, this.renderer.domElement)

        this.animate()
    }

    animate() {
        requestAnimationFrame(this.animate.bind(this))

        this.originCube.rotation.x += 0.01
        this.originCube.rotation.y += 0.01

        this.offsetCube.rotation.x -= 0.003
        this.offsetCube.rotation.y -= 0.002

        // this.controls.update()

        this.renderer.render(this.scene, this.camera)
    }

    createCube(x, y, z) {
        const cube = new THREE.Mesh(this.geometry, this.material)
        cube.position.x = x
        cube.position.y = y
        cube.position.z = z
        return cube
    }
}
