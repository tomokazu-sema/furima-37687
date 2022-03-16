function tax () {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const itemPriceValue = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    const tax = 0.1;
    const taxPriceValue = Math.floor(itemPriceValue * tax);
    addTaxPrice.innerHTML = `${taxPriceValue.toLocaleString()}`;
    profit.innerHTML = `${(itemPriceValue - taxPriceValue).toLocaleString()}`;
  });
}

window.addEventListener("load", tax);