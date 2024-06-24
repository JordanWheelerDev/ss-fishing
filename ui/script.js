document.addEventListener("DOMContentLoaded", function () {
  const baitItems = document.querySelectorAll(".bait-item");
  const baitTarget = document.getElementById("bait-target");
  const closeButton = document.getElementById("close-ui");

  window.addEventListener("message", function (event) {
    if (event.data.action === "openBaitUI") {
      document.getElementById("bait-ui").style.display = "block";
    } else if (event.data.action === "closeBaitUI") {
      document.getElementById("bait-ui").style.display = "none";
    }
  });

  baitItems.forEach((item) => {
    item.addEventListener("dragstart", function (e) {
      e.dataTransfer.setData("text/plain", e.target.dataset.bait);
    });
  });

  baitTarget.addEventListener("dragover", function (e) {
    e.preventDefault();
  });

  baitTarget.addEventListener("drop", function (e) {
    e.preventDefault();
    const bait = e.dataTransfer.getData("text/plain");
    fetch(`http://ss-fishing/selectBait`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify({ bait: bait }),
    });
  });

  closeButton.addEventListener("click", function () {
    fetch(`http://ss-fishing/closeUI`, {
      method: "POST",
    });
  });
});
