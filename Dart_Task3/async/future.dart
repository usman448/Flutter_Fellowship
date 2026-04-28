//Future is used when we donnot have value but in future assigned a value

Future<String>  fetchData(){ //this type is future delay
  return Future.delayed(
    Duration(seconds: 3),
    () => "Data loaded"
  );
}

Future<int> getnumber(){ //this type is complete future
  return Future.value(10);
}

Future<String> errorFuture() { //this type is failed future(error)
  return Future.error("Something went wrong");
}
void main(){
  fetchData().then((value){ //then is used to get value 
    print(value);
  });
  
  getnumber().then((value){
    print(value);
  });

  errorFuture().then((value){
    print(value);
  });
}

//fetchdata not call because it used delay so program should close before execution 
//so to overcome this problem we use async await in next section