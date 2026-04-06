import consumer from "./consumer"

console.log("COMMENTS JS LOADED 🚀")

document.addEventListener("turbo:load", () => {
  const el = document.getElementById("comments")

  console.log("ELEMENT:", el)

  if (!el) return

  const articleId = el.dataset.articleId

  console.log("ARTICLE ID:", articleId)

  consumer.subscriptions.create(
    { channel: "CommentsChannel", article_id: articleId },
    {
      connected() {
        console.log("✅ Connected to CommentsChannel")
      },

      received(data) {
        console.log("📩 Received:", data)

        const tbody = document.querySelector("#comments tbody")

        tbody.insertAdjacentHTML(
          "beforeend",
          `<tr>
            <td>${data.title}</td>
            <td>${data.body}</td>
            <td></td>
          </tr>`
        )
      }
    }
  )
})
