//import 'package:noteapp/constant/message.dart';
import 'package:samplesorder/constant/message.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
  if (val.length > max) {
    return "$messageInputMax $max";
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
}

/*****/
validInputSign(String valinput /*name of variable with text*/,
    String input /*Type of feild : email , password... */, int min, int max) {
  if (input.isEmpty) {
    return "$input cannot be empty";
  }
  if (valinput.length > max) {
    return "$valinput cannot be bigger than $max";
  }
  if (valinput.length < min) {
    return "$valinput cannot be smaller than $min";
  }
}

/********/
validNote(String note) {
  if (note.isEmpty || note.isNotEmpty) {
    return "";
  }
}

/*******/
validInputLength(String val, int min, int max) {
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
  if (val.length > max) {
    return "$messageInputMax $max digit";
  }
  if (val.length < min) {
    return "$messageInputMin $min digit";
  }
}
