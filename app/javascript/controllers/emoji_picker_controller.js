/* eslint-disable prettier/prettier */
/* eslint-disable no-console */
/* eslint-disable no-undef */
/* eslint-disable class-methods-use-this */
/* eslint-disable prettier/prettier */
import {Controller} from "@hotwired/stimulus";
import { createPopup } from '@picmo/popup-picker';
import {RichText} from "../classes/RichText";

// Connects to data-controller="emoji-picker"
export default class extends Controller {
    static targets = ["trixEditor", "pickerContainer"];

    connect() {
        console.log("Connected to emoji-picker");
        const buttonString = this.emojiButtonString();
        const emojiButton = this.emojiButtonTemplate(buttonString);
        let picker;
        const richText = new RichText(picker, emojiButton);
        picker = createPopup(
        {
            rootElement: this.pickerContainerTarget,
        },
        {
            // The element that triggers the popup
            triggerElement: emojiButton,
            // The element to position the picker relative to - often this is also the trigger element,
            referenceElement: emojiButton,
            // specify how to position the popup
            position: "bottom-start",
        }
        );

        picker.addEventListener("emoji:select", (event) => {
        this.trixEditorTarget.editor.insertString(event.emoji);
        });

        richText.setPicker(picker);
    }

    emojiButtonTemplate(buttonString) {
        const domParser = new DOMParser();
        return domParser
            .parseFromString(buttonString, "text/html")
            .querySelector("button");
    }

    emojiButtonString() {
        return `<button class="trix-button" id="emoji-picker" data-trix-action="popupPicker" tabindex="1">😀</button>`;
    }
}