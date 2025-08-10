import 'package:app/constants/enums.dart';

String getGenderLabelAsString(int gender) {
  switch (gender) {
    case 1:
      return 'Female';
    case 2:
      return 'Male';
    case 3:
      return 'Non-binary';
    default:
      return 'Unknown';
  }
}

Gender getGenderLabelAsEnum(int gender) {
  switch (gender) {
    case 1:
      return Gender.female;
    case 2:
      return Gender.male;
    case 3:
      return Gender.nonBinary;
    default:
      return Gender.unknown;
  }
}
