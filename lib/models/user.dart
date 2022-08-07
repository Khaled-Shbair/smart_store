class User {
  int? id;
  late String firstName;
  late String lastName;
  late String email;
  late String mobile;
  late String bio;
  late String jobTitle;
  late String latitude;
  late String longitude;
  late String country;
  late String image;
  late String active;
  late String emailVerifiedAt;
  late String imagesCount;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    bio = json['bio'];
    jobTitle = json['job_title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    image = json['image'];
    active = json['active'];
    emailVerifiedAt = json['email_verified_at'];
    imagesCount = json['images_count'];
  }
}
