import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { timestamp: Number };

  connect() {
    this.updateTime();
    this.interval = setInterval(() => this.updateTime(), 60000); // Every 60s
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateTime() {
    const seconds = Math.floor((new Date() - new Date(this.timestampValue * 1000)) / 1000);

    const days = Math.floor(seconds / (24 * 3600));
    const hours = Math.floor((seconds % (24 * 3600)) / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);

    let parts = [];
    if (days > 0) parts.push(`${days}d`);
    if (hours > 0) parts.push(`${hours}h`);
    if (minutes > 0 || parts.length === 0) parts.push(`${minutes}m`);

    this.element.innerText = `${parts.join(" ")}`;
  }
}
