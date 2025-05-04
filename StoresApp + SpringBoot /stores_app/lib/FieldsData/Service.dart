abstract class Service {
  String _fullName = '';
  String? _gender;
  String _email = '';
  int _ID = 0;
  int? level;
  String _password = '';
  String _confirmPassword = '';
  get fullName => _fullName;

  set fullName(value) => _fullName = value;

  get gender => _gender;

  set gender(value) => _gender = value;

  get email => _email;

  set email(value) => _email = value;

  get ID => _ID;

  set ID(value) => _ID = value;

  get getLevel => level;

  set setLevel(level) => level = level;

  get password => _password;

  set password(value) => _password = value;

  get confirmPassword => _confirmPassword;

  set confirmPassword(value) => _confirmPassword = value;
}
