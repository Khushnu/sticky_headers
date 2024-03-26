// To parse this JSON data, do
//
//     final creditData = creditDataFromJson(jsonString);

import 'dart:convert';

CreditData creditDataFromJson(String str) => CreditData.fromJson(json.decode(str));

String creditDataToJson(CreditData data) => json.encode(data.toJson());

class CreditData {
    Account account;
    List<Transaction> transactions;

    CreditData({
        required this.account,
        required this.transactions,
    });

    factory CreditData.fromJson(Map<String, dynamic> json) => CreditData(
        account: Account.fromJson(json["account"]),
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "account": account.toJson(),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    };
}

class Account {
    int id;
    String name;
    String currency;
    String currencyName;
    double balance;

    Account({
        required this.id,
        required this.name,
        required this.currency,
        required this.currencyName,
        required this.balance,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        balance: json["balance"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "currency": currency,
        "currency_name": currencyName,
        "balance": balance,
    };
}

class Transaction {
    int id;
    Type type;
    int amount;
    Details details;
    DateTime date;

    Transaction({
        required this.id,
        required this.type,
        required this.amount,
        required this.details,
        required this.date,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        amount: json["amount"],
        details: Details.fromJson(json["details"]),
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "amount": amount,
        "details": details.toJson(),
        "date": date.toIso8601String(),
    };
}

class Details {
    String description;
    String from;
    String? image;

    Details({
        required this.description,
        required this.from,
        required this.image,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        description: json["description"],
        from: json["from"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "from": from,
        "image": image,
    };
}

enum Type {
    CREDIT,
    DEBIT
}

final typeValues = EnumValues({
    "credit": Type.CREDIT,
    "debit": Type.DEBIT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
