class Person{
  String name;

  Person(this.name);
}

class Student extends Person{
  int rollno;
  int marks;

  Student(String name, this.rollno,this.marks) : super(name);

  void givetest(){
    print("Name: $name Rollnumber: $rollno appeared in exam \n----");
    if(marks>=80 || marks<=100){
      print("$name get A grade with $marks marks");
    }
    else if(marks>=60 ||marks<80){
      print("$name get B grade with $marks marks");
    }
    else{
      print("$name get C grade with $marks marks");
    }
  }

  Student.scholarship() :  rollno = 30, marks = 90, super("Ali"); //named constructor

  void scholarshipstd(){
    print("\n$name get scholarship with rollnumber $rollno now him/her tuition fees is zero");
  }
}

class Employee extends Person{
  int id;
  String post;
  var salary_per_day;
  int working_day;
  Employee(String name, this.id, this.post, this.salary_per_day, this.working_day) : super(name);

  void dowork(){
    if(working_day>0){
      num total=working_day*salary_per_day;
      print("\nsalary of $name of $working_day working day is Rs $total");
    }
  }
}
void main(){
  Student s1 = new Student("Ramzan", 27, 83);
  s1.givetest();
  Student s2 = new Student.scholarship();
  s2.scholarshipstd();

  Employee emp1 = new Employee("Fraz", 7629, "Manager", 1900, 26);
  emp1.dowork();
}