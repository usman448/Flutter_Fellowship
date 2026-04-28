//encapsulation means protect data from direct access
//declare _variable use getter/setter method to access data

class Student{
  double _gpa = 0.0;
  bool _promoted = false;

  double get studentgpa => _gpa; // getter method

  set setgpa(double newgpa){  //setter method
    if(newgpa>=2.0 && newgpa<=4.0){
      _gpa = newgpa;
      if(_gpa>=2.0){
        _promoted = true;
      }
      else{
        _promoted = false;
      }
      print("gpa update and promotion status checked");
    }
    else{
      print("invalid gpa");
    }
  }

  bool get studentpromation => _promoted; //getter method

}

void main(){
  Student s1 = new Student();
  print(s1.studentgpa);
  s1.setgpa = 3.4;
  print(s1.studentpromation);


}