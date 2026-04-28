//map will store data in key:value pair , key always be unique
void main(){
  Map<String, String> capitalcity = { 
    "pakistan": "islamabad",
    "france":"paris"
  };
  print(capitalcity['pakistan']);

  print(capitalcity.containsKey("pakistan")); //check by key
  print(capitalcity.containsValue("paris")); //check by value
  // capitalcity.addEntries("iran":"tehran");
  capitalcity.putIfAbsent('iran', () => 'tehran');
  for(var city in capitalcity.keys){ //it just give key
    print(city);
  }
  for(var city in capitalcity.values){ //it just give value
    print(city);
  }
  for(var city in capitalcity.entries){ //it give both value and key
    print("${city.value} is capital of ${city.key}");
  }

  capitalcity.update('pakistan', (val) => "rawalpindi"); //update existing value
  print(capitalcity['pakistan']);
  capitalcity.remove('pakistan'); //simple delete k liye
  print(capitalcity['pakistan']);
  capitalcity.removeWhere((key, value) => value=="paris"); //delete specfic pair
  print(capitalcity);
}