/* eslint-disable prettier/prettier */
/* eslint-disable eqeqeq */
/* eslint-disable no-undef */
/* eslint-disable no-use-before-define */
/* eslint-disable consistent-return */
/* eslint-disable no-param-reassign */
/* eslint-disable prettier/prettier */
export function getMetaValue(name) {
  const element = findElement(document.head, `meta[name="${name}"]`);
  if (element) {
    return element.getAttribute("content");
  }
}

export function findElement(root, selector) {
  if (typeof root == "string") {
    selector = root;
    root = document;
  }
  return root.querySelector(selector);
}

export function removeElement(el) {
  if (el && el.parentNode) {
    el.parentNode.removeChild(el);
  }
}

export function insertAfter(el, referenceNode) {
  return referenceNode.parentNode.insertBefore(el, referenceNode.nextSibling);
}