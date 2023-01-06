class Bill {
  double amount;

  Bill({
    this.amount = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      amount: map['amount'] as double,
    );
  }
}
