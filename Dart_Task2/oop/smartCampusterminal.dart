import 'dart:io';
class Student{
  String name;
  var rollno;
  num gpa;
  String cousre;

  Student(this.name, this.rollno, this.gpa, this.cousre);

  void display(){
    print("$name you are successfully login");
    print("your result \nCourse: $cousre \nGPA: $gpa ");
  }

  Student.guest() : name = "Guest" ,rollno = "xxx", gpa = 0.0, cousre = "Not defined";
}

void main(){
  Student s1 = new Student('ali', 1, 3.3, "SE");
  Student s2 = new Student('amna', 2, 3.1, "CS");
  Student s3 = new Student('jamal', 3, 2.3, "SE");
  Student s4 = new Student('farhan', 4, 3.34, "CS");
  
  Student s5 = new Student.guest();
  Student s6 = new Student.guest();

  List<Student> studentsList = [s1, s2, s3, s4, s5, s6];

  bool isRunning = true;

  while (isRunning) {
    print("=== Welcome Portal ===");
    print("1. Press 1 for Student Login");
    print("2. Press 2 for Guest Entry");
    print("3. Exit");
    stdout.write("Choose an option: ");
    
    String? choice = stdin.readLineSync();

    if (choice == "1") {
      // --- Student Search Logic ---
      stdout.write("Enter your Roll Number: ");
      var inputRoll = stdin.readLineSync();
      int? searchRoll = int.tryParse(inputRoll ?? "");

      bool found = false;
      for (var s in studentsList) {
        if (s.rollno == searchRoll) {
          s.display(); // Agar mil gaya toh display call hoga
          found = true;
          break; // Loop rok do kyunke student mil gaya
        }
      }

      if (!found) {
        print("Error: Roll Number $inputRoll not found!");
      }

    } else if (choice == "2") {
      // --- Guest Logic ---
      Student guestUser = Student.guest();
      guestUser.display();

    } else if (choice == "3") {
      print("Goodbye!");
      isRunning = false; // Loop khatam karne ke liye
    } else {
      print("Invalid option, try again.");
    }
  }

}