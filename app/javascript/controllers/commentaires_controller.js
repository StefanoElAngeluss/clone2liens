/* eslint-disable no-param-reassign */
/* eslint-disable lines-between-class-members */
/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
/* eslint-disable prettier/prettier */
/* eslint-disable dot-notation */
/* eslint-disable class-methods-use-this */
/* eslint-disable no-console */
/* eslint-disable import/newline-after-import */
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    initialize() {}
    connect() {}
    toggleForm(event) {
        console.log("J'ai cliquer sur le bouton !!!")
        event.preventDefault()
        event.stopPropagation()
        const formID = event.params["form"]
        const commentaireContenuID = event.params["contenu"]
        const editButtonID = event.params["edit"]

        const form = document.getElementById(formID)
        const commentaireContenu = document.getElementById(commentaireContenuID)
        const editButton = document.getElementById(editButtonID)

        form.classList.toggle("d-none")
        form.classList.toggle("mt-5")
        commentaireContenu.classList.toggle("d-none")
        this.toggleEditButton(editButton)
    }

    toggleEditButton(editButton) {
        if (editButton.innerText === "Editer") {
            editButton.innerText = "Annuler"
            this.toggleEditButtonClass(editButton)
        } else {
            editButton.innerText = "Editer"
            this.toggleEditButtonClass(editButton)
        }
    }

    toggleEditButtonClass(editButton) {
        editButton.classList.toggle("btn-secondary")
        editButton.classList.toggle("btn-warning")
    }
}
