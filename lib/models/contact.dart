class Contact {
  String name;
  String primaryPhone;
  String homePhone;
  String officePhone;
  String mobilePhone;

  Contact({
    this.name,
    this.primaryPhone,
    this.homePhone,
    this.mobilePhone,
    this.officePhone
  });

  Contact.phoneDirectory(this.name, this.primaryPhone);

  factory Contact.fromJson(Map<String, dynamic> data) => new Contact(
    name: data["name"],
    primaryPhone: data["primaryPhone"],
    homePhone: data["homePhone"],
    mobilePhone: data["mobilePhone"],
    officePhone: data["officePhone"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "primaryPhone": primaryPhone,
    "homePhone": homePhone,
    "mobilePhone": mobilePhone,
    "officePhone": officePhone,
  };

}