import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import '../model/expense.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(this.expenses,
              this.onRemoveExpense,
      {super.key}); // we have to receive list of expenses as input here

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //return ListView.builder(itemBuilder: (cnx,index){
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (cnx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin:EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal ) ,
            ),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])) //Text(expenses[index].title),instead of this add expenseitems, pass a single value.
        ); //whenevr there is multiple items displayed above each other we use Column. if we have list of unclear length as in here users can as many as expenses.use ListView , by that we will get a scrollable list which create all items immediatly. in here we have many items that are not visible initially , instead of using lisyt views normally ie ListView(children: ), use builder constructor function. this will create a scrollable list(Listview) and create list items only when they are visible.
    //we need to pass itemBuilder which is a function which will return a wiget. we can create a function and point to it or create an anonymous function. context and index is automatically provided by flutter then return a widget.
    //we can use arrow function which directly return a value. as of now the widget to be returned id a text.
    // otherthan itembuilder pass another value itemCount , ie how many items can be displayed. in there pass expenses.length. flutter calls itemBuilder as long as the itemCount. value will be assigned to index. for showing title of expense use index ie expenses[index].title.
  }
}
//we need to swip away expenses from the list . For that we can use 'dismissable': it need need a child which in here is ExpenseItem. For key we accept it i  the parent widget and forward it to the statelesswidget. Key is for making widgets uniqyely identifiable. such a key can be generated using valuekey. Valuekey wnats some input for unique identification criteria.
//using dismmisible we didnt actually remove the data. for that add onDismissed parameter which allow to you trigger a function. add a _removeExpense function in expenses.dart. Accept the function here . Add this on onDismissed parameter . it ca do two things according to the direction it is swiped. so onDismmied need a function.
