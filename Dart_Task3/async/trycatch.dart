//try catch is used to handle exception and save program from crashing 

//await keyword pause the function untill future will complete

import 'dart:async';

Future<String>  fetchData(){ //this type is future delay
  return Future.delayed(
    Duration(seconds: 3),
    () => "Data loaded"
  );
}

Future<void> loadData() async{ //here we use async and await method to completely load future data
  print("loading....");
  String data = await fetchData();
  print(data);
}

Future<int> getnumber(){ //this type is complete future
  return Future.value(10);
}

Future<String> errorFuture() { //this type is failed future(error)
  return Future.error("Something went wrong");
}

Future<void> getData() async{ //here we use try catch block to handle exception
  try{
    String result = await errorFuture();
    print(result);
    print("no error");
  }
  catch(e){
    print("Error: $e");
  }
  finally{
    print("program end");
  }
}
void main() async{
  
  await loadData();
  
  getnumber().then((value){
    print(value);
  });

  await getData();
}