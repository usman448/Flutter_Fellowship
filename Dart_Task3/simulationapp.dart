Future<void> LoadingApp() async{
  print("Loading app......");
  await Future.delayed(Duration(seconds: 2));
  print("please wait....");
  await Future.delayed(Duration(seconds: 2));
  print("Welcome to app");
}

void main() async{
  await LoadingApp();
}