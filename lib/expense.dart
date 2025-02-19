import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter course',
      amount: 19.9,
      date: DateTime.now(),
      category: Categorys.work,
    ),
    Expense(
      title: ' cinema',
      amount: 10.3,
      date: DateTime.now(),
      category: Categorys.leisure,
    ),
  ]; //a list of type Expense model, is created . when we create a class a model is created along with that
  //we have to make buid widgets more lean for that we are creating aother file for building lists
  void addExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense,),
    );
  } //incontext wants a build context value. outside build method we have context since we are in a class that extends state, flutter automatically add a context property. context : a widget meta info( metadata managed) -> info that related to other widgets

  //builder always wants a function as a value. here a function that returns a widget.

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();//if we remove two items , then the message of first one will be removed immediatly
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'undo',
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      )
  );//scaffoldMessenger has an off method, which needs a context as value. showSnackbar will show info message which needs  snackBar value which can be created using snackBar object, it need content as widgett, here we can use tect. it also has a duration which can be set using Duration object. we can also add an action, created using SnackBarAction class , which want label undo and onpressed parameter which define the function to be executed when undo is clicked. in onpressed setState and inside that insert (not add) because we want to insert the expense in the exct position where we removed it. insert wants the index and the expense that we deleted , get this using index : ExpenseIndex.
  }//for removig an expense while swipping it away

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('no expenses here'),);
    if(_registeredExpenses.isNotEmpty)//isNotEmpty is a utility property to find whether a list is empty or not.
      {
        mainContent =  ExpenseList(_registeredExpenses,_removeExpense);//overwrite main content with a different value.
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: addExpenseOverlay , icon: Icon(Icons.add))
          //add the function addExpense like a pointer to onPressed ,because we dont want to execute function , we want execute function when the button is pressed.
        ],
      ),
      //to add bar at the top of the screen. AppBar wiget has many parameters. actions need a list of widgets, inside that we can use anything we want. IconButton is a button that only contain an icon.
      body: Column(
        children: [
          Text('chart'),
          Expanded(child: mainContent),
          //use Expenseslist here and pass _registeredExpenses as positional parameter
          // inside column we have another column type widget which will cause problrm. so use 'expanded' .
          // we have to print not only totle but many informations for that create another file.
        ],
      ),
    );
  }
}
