import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // DOM要素を取得するためのターゲットを定義
  static targets = ["timer", "start", "stop", "reset", "durationMinutes"]

  // ストップウォッチの状態を管理するためのプロパティを定義
  startTime = undefined
  timeoutId = undefined
  elapsedTime = 0

  // コントローラーが接続されたときに呼び出されるメソッド
  connect() {
    this.setButtonStateInitial();
  }

  setButtonStateInitial() {
    this.startTarget.classList.remove("inactive")
    this.stopTarget.classList.add("inactive")
    this.resetTarget.classList.add("inactive")
  }

  // スタートボタンがクリックされたときに呼び出されるメソッド
  start() {
    if (this.startTime) return; // すでにスタートしている場合は何もしない

    this.startTime = Date.now() - this.elapsedTime; // 経過時間を考慮して開始時間を設定
    this.updateTimer(); // タイマーを更新
    this.setButtonStateRunning(); // ボタンの状態を更新
  }

  // ストップボタンがクリックされたときに呼び出されるメソッド
  stop() {
    if (!this.startTime) return; // ストップウォッチがスタートしていない場合は何もしない

    clearTimeout(this.timeoutId); // タイマーの更新を停止
    this.elapsedTime = Date.now() - this.startTime; // 経過時間を保存
    this.durationMinutesTarget.value = Math.floor(this.elapsedTime / 60000); // 経過時間を分単位でフォームにセット
    this.startTime = undefined; // 開始時間をリセット
    this.setButtonStateStopped(); // ボタンの状態を更新
  }

  // リセットボタンがクリックされたときに呼び出されるメソッド
  reset() {
    clearTimeout(this.timeoutId); // タイマーの更新を停止
    this.startTime = undefined; // 開始時間をリセット
    this.elapsedTime = 0; // 経過時間をリセット
    this.timerTarget.textContent = "00:00"; // タイマー表示をリセット
    this.setButtonStateInitial(); // ボタンの状態を初期化
  }

  // タイマーを更新するためのメソッド
  updateTimer() {
    const elapsedTime = Date.now() - this.startTime; // 経過時間を計算
    const minutes = String(Math.floor(elapsedTime / 60000)).padStart(2, "0"); // 分を計算してゼロ埋め
    const seconds = String(Math.floor((elapsedTime % 60000) / 1000)).padStart(2, "0"); // 秒を計算してゼロ埋め
    this.timerTarget.textContent = `${minutes}:${seconds}`; // タイマー表示を更新

    this.timeoutId = setTimeout(() => this.updateTimer(), 1000); // 1秒ごとにタイマーを更新
  }

  // ボタンの状態を更新するためのメソッド
  setButtonStateRunning() {
    this.startTarget.classList.add("inactive")
    this.stopTarget.classList.remove("inactive")
    this.resetTarget.classList.add("inactive")
  }

  // ボタンの状態を更新するためのメソッド
  setButtonStateStopped() {
    this.startTarget.classList.remove("inactive")
    this.stopTarget.classList.add("inactive")
    this.resetTarget.classList.remove("inactive")
  }
}
