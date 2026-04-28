abstract class Menuitem{
  String name;
  num _price;

  Menuitem(this.name, this._price); //constructor
  num get price => _price; //getter method
  set setprice(num value){ //setter
    if(value>0){
      _price = value;
    }
    else{
      print("enter price greater than 0");
    }
  }
  void discount(); //abstract method
  void detail(); //abstract method
}

class Paytax{
  void tax(){}
}

class Pizza extends Menuitem implements Paytax{
  Pizza(String name, num price) : super(name, price);

  void discount(){
    print("Discount on $name is 15% so new price is ${price-price*0.15}");
  }

  void detail(){
    print("Item name: $name \nPrice: $price");
  }

  void tax(){
    print("Tax on $name is 10% which is ${price*0.10}");
  }
}

class Burger extends Menuitem {
  Burger(String name, num price) : super(name, price);

  void discount(){
    print("Discount on $name is 5% so new price is ${price-price*0.05}");
  }

  void detail(){
    print("Item name: $name \nPrice: $price");
  }

}

void main(){
  List<Menuitem> cart = [
    Pizza('chicken tikka', 1500),
    Pizza('royal pizaa', 3400),
    Burger("andy wla", 200),
    Burger("zinger", 450)
  ];

  print("---menu---");
  for(var item in cart){
    item.detail();
    item.discount();

    if(item is Paytax){
      (item as Paytax).tax();
    }
  }
}