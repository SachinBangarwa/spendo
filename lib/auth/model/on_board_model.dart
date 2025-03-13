class OnBoardModel {
  String title;
  String imgUrl;
  String description;

  OnBoardModel(
      {required this.title, required this.imgUrl, required this.description});

  static String path = 'assets/images/on_board';

  static List<OnBoardModel> contentList = [
    OnBoardModel(
        title: 'Gain total control\n   of your money',
        imgUrl: "${path}1.png",
        description:
            'Become your own money manager\n      and make every cent count'),
    OnBoardModel(
        title: 'Know where your\n      money goes',
        imgUrl: "${path}2.png",
        description:
            'Track your transaction easily,\nwith categories and financial report'),
    OnBoardModel(
        title: 'Planning ahead',
        imgUrl: "${path}3.png",
        description:
            'Setup your budget for each category\n  so you in control'),
  ];
}
