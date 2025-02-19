import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{
  ExpenseItem(this.expense,{super.key});

  final Expense expense;//for data we nedd expense
  @override
  Widget build(BuildContext context) {
   return Card(
     child: Padding(padding: const EdgeInsets.symmetric(
       horizontal: 20,
       vertical: 16
     ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:[
           Text(
             expense.title,
             style: Theme.of(context).textTheme.titleLarge,
           ),
             const SizedBox(height: 4,),
             Row(children: [
               Text('\$${expense.amount.toStringAsFixed(2)}'),//braces take it as a single value,to add dollar symbol which is like a keyword in dart add a \ infront:escaping.
               const Spacer(),
               Row(children: [
                 Icon(categoryIcons[expense.category]),//use icons defined in expense model
                 const SizedBox(width: 8,),
                 //Text(expense.date.toString())//for date acess formatted date , no need to add () because its a getter
                 Text(expense.formattedDate),
               ],),
             ],)

         ],
         ),
     ),
   );//card:give nice card look
    //use this in expense file
    //card doesnt have paddding parameter (internal space), we can wrap it in padding widget.
    //in first row we want title then amount and so on.so change text to column
    //inside column we need row widget to display the mount category an icon and date time to the left of it.
    //text widget is a string so dounble is not supported (toString) toStringAsFixed it will imit fraction to 2.
    //add row inside row to group catogory and date together to the right.
    //spacer:it will take all the spaces it can take between other widgets.
  }
}