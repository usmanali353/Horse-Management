import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class upcoming_tasks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _upcoming_tasks_state();
  }

}
class _upcoming_tasks_state extends State<upcoming_tasks>{
  CalendarController _calendarController;

  Map<DateTime, List> _events;
  List _selectedEvents;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              initialSelectedDay: DateTime.now(),
              calendarController: _calendarController,
              availableGestures: AvailableGestures.none,
              locale: 'en_us',
              events: _events,
              onDaySelected:_onDaySelected,
            ),
            const SizedBox(height: 8.0),
            Expanded(child: _buildEventList()),
          ],
        )
    );

  }
  @override
  void initState() {
    _calendarController=new CalendarController();
    setState(() {
      final _Selected_Date=DateTime.now();
      _events={
        _Selected_Date.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
        _Selected_Date.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
        _Selected_Date.add(Duration(days: 11)): ['Event A11', 'Event B11'],
        _Selected_Date.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
        _Selected_Date.add(Duration(days: 22)): ['Event A13', 'Event B13'],
        _Selected_Date.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
      };
      _selectedEvents = _events[_Selected_Date] ?? [];
    });
  }
  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    //print('CALLBACK: _onDaySelected');
    setState(() {
      _calendarController.setSelectedDay(day);
      //  _Selected_Date =day;
      _selectedEvents = events;
    });
  }

  Widget _buildEventList() {
    return ListView(
      shrinkWrap: true,
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          leading: Icon(Icons.event_available,size: 50,),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }

}