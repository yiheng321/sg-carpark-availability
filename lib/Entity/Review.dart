class Review {
  late int _id;
  late String _carParkNo;
  late int _cost;
  late int _convenience;
  late int _security;
  late int _numOfReviewCost;
  late int _numOfReviewConvenience;
  late int _numOfReviewSecurity;

  Review.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _carParkNo = map['carParkNo'];
    _cost = map['cost'];
    _convenience = map['convenience'];
    _security = map['security'];
    _numOfReviewCost = map["numOfReviewCost"];
    _numOfReviewConvenience = map["numOfReviewConvenience"];
    _numOfReviewSecurity = map["numOfReviewSecurity"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'carParkNo': _carParkNo,
      'cost': _cost,
      'convenience': _convenience,
      'security': _security,
      'numOfReviewCost': _numOfReviewCost,
      'numOfReviewConvenience': _numOfReviewConvenience,
      'numOfReviewSecurity': _numOfReviewSecurity
    };
    return map;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get security => _security;

  set security(int value) {
    _security = value;
  }

  int get convenience => _convenience;

  set convenience(int value) {
    _convenience = value;
  }

  int get cost => _cost;

  set cost(int value) {
    _cost = value;
  }

  String get carParkNo => _carParkNo;

  set carParkNo(String value) {
    _carParkNo = value;
  }


  Review(
      this._id,
      this._carParkNo,
      this._cost,
      this._convenience,
      this._security,
      this._numOfReviewCost,
      this._numOfReviewConvenience,
      this._numOfReviewSecurity);

  int get numOfReviewCost => _numOfReviewCost;

  set numOfReviewCost(int value) {
    _numOfReviewCost = value;
  }

  int get numOfReviewSecurity => _numOfReviewSecurity;

  set numOfReviewSecurity(int value) {
    _numOfReviewSecurity = value;
  }

  int get numOfReviewConvenience => _numOfReviewConvenience;

  set numOfReviewConvenience(int value) {
    _numOfReviewConvenience = value;
  }
}
