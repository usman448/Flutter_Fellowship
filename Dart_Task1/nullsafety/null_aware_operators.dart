//it secure our app to crash 
// null safe access (?.)
// fallback operator (??)
//null assertion / bang operator (!)
void main(){
  String? city;
  print(city?.length); //this ? is used if value is null then it give null
  city = "attock";
  print(city.length); //but if u sure variable have value 


String? userCity;
String finalCity = userCity ?? "Unknown"; // Hum chahte hain agar city na ho, toh "Unknown" dikhayein
print(finalCity); // Output: Unknown

userCity = "Lahore";
print(userCity ?? "Unknown"); // Output: Lahore

String? secretCode ="xyz789";
// Dart ko shak hai ke ye null ho sakta hai, lekin humne '!' laga kar usay chup karwa diya. 

print(secretCode.length); // error of unhandle
}