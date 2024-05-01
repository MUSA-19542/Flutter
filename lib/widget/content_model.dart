class UnboardingContent
{
  String image;
  String title;
  String description;

  UnboardingContent({required this.image, required this.title, required this.description});
}

List<UnboardingContent> contents=[
  UnboardingContent(image:"images/screen1.png", title : 'Select From Our \n    Best Menu \n ', description:'Pick You Food From Our Menu \n       More than 35 times'),
  UnboardingContent(image:"images/screen2.png", title : 'Payment Methods \n ', description:'            You can Pay From Cash \nOr Card & GPay & Online Banking Apps'),
  UnboardingContent(image:"images/screen3.png", title : 'Home Delivery \n ', description:'Delivery At Your Door Step \n       Hot & Fresh & Cheap'),
];