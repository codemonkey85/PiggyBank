"use strict"

import { html, render as renderHtml } from "../../lib/lit-html/lit-html.js"
import { getUuid } from "../PiggyBankUtil.js"

const template = (d) => html`
  <label for='selectCommodityId-${d.uuid}'>${d.label}</label>
  <select id='selectCommodityId-${d.uuid}' class='select-commodity-id form-control'>
    <option value=''>[Choose Commodity]</option>
  </select>
`

export class CommoditySelectMenuView extends Backbone.View {
  render(commodityId, label) {
    label = label || "Commodity"
    renderHtml(template({ uuid: getUuid(), label }), this.el)
    this.addCommodityOptions(window.piggybank.commodities.models, commodityId)
    return this
  }

  getSelectedId() {
    return this.$("select").find(":selected").val()
  }

  addCommodityOptions(collection, commodityId) {
    const commoditySelect = this.$(".select-commodity-id")
    for (let model of collection) {
      const option = `<option value='${model.get("id")}'>${model.get("name")}</option>`
      commoditySelect.append(option)
    }

    commoditySelect.val(commodityId)
    commoditySelect.on("change", (e) => this.trigger("change", e))
  }
}
