class CardModel {
  String cardName;
  String cardNumber;
  String cardCVV;
  String cardDate;


  CardModel(this.cardName, this.cardNumber, this.cardCVV, this.cardDate);

  Map<String, dynamic> toJson() {
    return {
      'cardName': cardName,
      'cardNumber': cardNumber,
      'cardCVV': cardCVV,
      'cardDate': cardDate,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
     json['cardName'],
     json['cardNumber'],
     json['cardCVV'],
     json['cardDate'],

    );
  }
}
