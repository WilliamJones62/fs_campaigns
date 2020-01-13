function getData(data) {
  var p1 = data.replace('[', "");
  var p2 = p1.replace(']', "");
  p1 = p2.replace(/"/g, "");
  p2 = p1.replace(/,/g, "");
  var data_array = p2.split(" ");
  data_array.shift();
  data_array.pop();
  return data_array;
}

function partUoms(id) {
  var u = id.replace("part_desc", "part_uom");
  var uom = document.getElementById(u);
  //* work out UOM for part
  var desc = document.getElementById(id);
  var uoms = document.getElementById("alluoms").innerHTML;
  var uoms_array = getData(uoms);
  uom.value = uoms_array[desc.selectedIndex];
  if (uom.value == '~') {
    uom.value = ' ';
  }
}
