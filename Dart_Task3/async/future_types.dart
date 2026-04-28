void exampleThen() {
  print("Order placing...");
  
  Future.delayed(Duration(seconds: 3), () => "Pizza 🍕")
    .then((value) {
      print("Received: $value"); // Yeh 3 sec baad chalega
    });

  print("Checking other apps..."); // Yeh foran chal jayega
}

void exampleCatch() {
  Future.error("Out of Stock!")
    .then((value) => print(value))
    .catchError((error) {
      print("Error: $error"); // Output: Error: Out of Stock!
    });
}

void exampleWait() async {
  print("Downloading files...");
  
  // Teeno files aik saath download hona shuru hongi
  List results = await Future.wait([
    Future.delayed(Duration(seconds: 1), () => "File A"),
    Future.delayed(Duration(seconds: 2), () => "File B"),
    Future.delayed(Duration(seconds: 2), () => "File C"),
  ]);

  print(results); // [File A, File B, File C] (Total time: 2 sec, not 5!)
}
void main() {
  exampleThen();
  exampleCatch();
  exampleWait();
}