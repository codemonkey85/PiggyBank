"use strict"

import { html, render as renderHtml } from "../../lib/lit-html/lit-html.js"

const template = (d) => html`
  <div class='row'>
    <div class='col'>
      <h1>Oink! Oink!</h1>
      <p>Welcome to Piggy Bank.</p>
    </div>
  </div>
`

export class HomeView extends Backbone.View {
  render() {
    renderHtml(template(), this.el)
    return this
  }
}
