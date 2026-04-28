//polymorphism same method name but different behavior
//also called method overriding 
//parent reference -> child object

class Account{
  void accounttype(){
    print("Generic account");
  }
  void display(){
    print("access parent class method if not in child class");
  }
}

class CurrentAccount extends Account{
  void accounttype(){
    print("this is current account");
  }
}

class SavingAccount extends Account{
  void accounttype(){
    print("this is saving account");
  }
}

void main(){
  Account current = new CurrentAccount();
  Account saving = new SavingAccount();

  current.accounttype();
  saving.accounttype();
  current.display();
}