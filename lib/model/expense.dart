import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();// yMd() creates a formatter object which can be used to format date.year month day.
const uuid = Uuid();
enum Categorys { food,travel,leisure,work}

const categoryIcons = {
  Categorys.food: Icons.lunch_dining,
  Categorys.travel: Icons.flight_takeoff,
  Categorys.leisure: Icons.movie,
  Categorys.work: Icons.work,
};

class Expense{
  Expense({
  required this.title,required this.amount,required this.date,required this.category
  }) : id = uuid.v4();


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categorys category;

  String get formattedDate{
    return formatter.format(date);//returns  string with formatted date.
  }
}
//add categoryIcons whose value is map,values will be enum catorgy icon to be displayed
//add a getter formattedDate[getter: get keyword ,return type, skip (), add {}, inside return] . install intl flutter .

//model for adding chart
class Expensebucket {
  const Expensebucket({
  required this.catgory,
  required this.expenses
  });

  Expensebucket.forCategory(List<Expense> allExpenses, this.catgory)
  : expenses = allExpenses.where((expense) => expense.category == catgory).toList();//extra constructor we are using.

  final Categorys catgory;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses) {
      sum += expense.amount;
    }
      return sum;
  }
}