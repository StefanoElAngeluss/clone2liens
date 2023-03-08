/* eslint-disable import/prefer-default-export */
/* eslint-disable no-undef */
/* eslint-disable import/newline-after-import */
import { Application } from '@hotwired/stimulus'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
