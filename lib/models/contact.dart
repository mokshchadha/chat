class Contact {
  final String name;
  final String phone;
  final String company;
  final String designation;
  final String fromNo;

  Contact(
      {required this.name,
      required this.phone,
      required this.company,
      required this.designation,
      required this.fromNo});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] != null ? json['name'].split('-')[0] : '',
      phone: json['phoneNumber'] ?? '',
      company: json['name'] != null && json['name'].split('-').length > 1
          ? json['name'].split('-')[1]
          : 'NA',
      designation: json['designation'] ?? '',
      fromNo: json['fromNo'] ?? '919614063333',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'company': company,
        'designation': designation,
      };
}
