class Task {
  // Properties (Variables)
  String title;        // Task ka naam
  bool isCompleted;    // Task complete hua ya nahi
  DateTime createdAt;  // Kab banaya

  // Constructor - Object banane ka tareeka
  Task({
    required this.title,      // title dena zaroori hai
    this.isCompleted = false, // default false (incomplete)
    required this.createdAt,  // time dena zaroori hai
  });

  // Optional: JSON conversion ke liye (agr database use karo toh)
  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
      };
}