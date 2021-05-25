function taxTax() {
  const itemPrice = document.getElementById("item-price");

  itemPrice.addEventListener('input',function(){
    const priceItem = itemPrice.value
    const tax = 0.1;
    const addTax = priceItem * tax;
    const profit = priceItem - addTax;
    const taxPrice = document.getElementById("add-tax-price");
    const profitPrice = document.getElementById("profit");
    taxPrice.innerHTML = Math.floor(addTax);
    profitPrice.innerHTML = Math.floor(profit);
  })
}

window.addEventListener('load', taxTax)