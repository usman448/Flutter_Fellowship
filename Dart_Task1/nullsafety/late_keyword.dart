//late keyword is used when you don't assign value now but promise to assign value in future "before using"
void main(){
  late String password;
  password ="abc123";
  print(password);
  print(password.length);
}