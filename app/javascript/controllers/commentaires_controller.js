/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
/* eslint-disable prettier/prettier */
/* eslint-disable dot-notation */
/* eslint-disable class-methods-use-this */
/* eslint-disable no-console */
/* eslint-disable import/newline-after-import */
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    // initialize() {
    //     console.log('Initialisation du controller commentaires')
    // }

    // connect() {
    //     console.log('Salut les commentaires !!!')
    // }

    toggleForm(event) {
        console.log("J'ai cliquer sur le bouton !!!")
        event.preventDefault()
        event.stopPropagation()
        const formID = event.params["form"]
        const commentaireContenuID = event.params["contenu"]
        const form = document.getElementById(formID)
        form.classList.toggle("d-none")
        form.classList.toggle("mt-5")
        const commentaireContenu = document.getElementById(commentaireContenuID)
        commentaireContenu.classList.toggle("d-none")
    }
}
