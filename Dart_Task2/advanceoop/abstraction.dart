//abstraction means hiding internal implementation and showing only essential feature of object to user
//object not created of abstract class but child class must have abstract method
abstract class Bank{
  void interestrate(); //abstract method

  void Welcomemessage(){
    print("Welcome to bank");
  }
}

class HBL extends Bank{
  void interestrate(){
    print("interest rate of HBL is 10%");
  }
}

void main(){
  HBL mybank = HBL();
  mybank.Welcomemessage();
  mybank.interestrate();
}