final String tableContacts = 'contacts';

class ContactFields {
  static final List<String> values = [
    id,
    contactName,
    contactNumber,
    contactAddress
  ];

  static final String id = '_id';
  static final String contactName = 'contactName';
  static final String contactNumber = 'contactNumber';
  static final String contactAddress = 'contactAddress';
}

class Contact {
  final int? id;
  final String contactName;
  final String contactNumber;
  final String contactAddress;

  const Contact(
      {this.id,
      required this.contactName,
      required this.contactNumber,
      required this.contactAddress});

  Contact copy({
    int? id,
    String? contactName,
    String? contactNumber,
    String? contactAddress,
  }) =>
      Contact(
        id: id ?? this.id,
        contactName: contactName ?? this.contactName,
        contactNumber: contactNumber ?? this.contactNumber,
        contactAddress: contactAddress ?? this.contactAddress,
      );

  static Contact fromJson(Map<String, Object?> json) => Contact(
        id: json[ContactFields.id] as int?,
        contactName: json[ContactFields.contactName] as String,
        contactNumber: json[ContactFields.contactNumber] as String,
        contactAddress: json[ContactFields.contactAddress] as String,
      );

  Map<String, Object?> toJson() => {
        ContactFields.id: id,
        ContactFields.contactName: contactName,
        ContactFields.contactNumber: contactNumber,
        ContactFields.contactAddress: contactAddress,
      };
}
