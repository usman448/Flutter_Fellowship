void main(){
  greeting("Ramzan",1); //order of values important
  aboutcar(color: 'white', brand: 'audi'); //order of value not important
}

void greeting(String name, int num){
  print("$num hello $name this is a parameterized function");
}

void aboutcar({required String brand, required String color}){ //named parameterized
  print("this is a $color $brand");
}