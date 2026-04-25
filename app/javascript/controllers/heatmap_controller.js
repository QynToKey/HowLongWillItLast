import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    requestAnimationFrame(() => requestAnimationFrame(() => {
      this.element.scrollLeft = this.element.scrollWidth
    }))
  }
}
