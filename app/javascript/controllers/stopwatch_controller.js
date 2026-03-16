import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // DOM要素を取得するためのターゲットを定義
  static targets = ["timer", "start", "stop", "reset"]

  // ストップウォッチの状態を管理するためのプロパティを定義
  startTime = undefined
  timeoutId = undefined
  elapsedTime = 0

  connect() {
    console.log(this.timerTarget)
    console.log(this.startTarget)
    console.log(this.stopTarget)
    console.log(this.resetTarget)
  }
}
