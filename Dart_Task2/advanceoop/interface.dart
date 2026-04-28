//every class in dart is behave like interface
//it define set of all method in class must be implement

class Printer{
  void printData(){}
}

class Scanner{
  void scanData(){}
}

class AllinOne implements Printer,Scanner{
  void printData(){
    print("print data");
  }

  void scanData(){
    print("scan data");
  }
}

void main(){
  AllinOne machine = AllinOne();
  machine.scanData();
  machine.printData();
}