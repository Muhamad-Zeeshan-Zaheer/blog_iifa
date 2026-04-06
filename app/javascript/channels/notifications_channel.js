import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("Connected to NotificationsChannel")
  },

  received(data) {
    console.log(data)

    const notifications = document.getElementById("notifications")
    if (notifications) {
      notifications.insertAdjacentHTML(
        "beforeend",
        `<div class="alert alert-info">${data.message}</div>`
      )
    }
  }
})
