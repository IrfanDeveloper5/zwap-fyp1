import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final List<int> _selectedContainerIndices1 = [];
  final List<int> _selectedContainerIndices2 = [];

  final List<Widget> _iconsColumn1 = [
    const Icon(Icons.ac_unit),
    const Icon(Icons.access_alarm),
    const Icon(Icons.accessibility),
    const Icon(Icons.accessible),
    const Icon(Icons.account_balance),
  ];

  final List<String> _titlesColumn1 = [
    'Electroinics',
    'Wearables',
    'Furnitures',
    'Beauty',
    'Cloths',
  ];

  final List<Widget> _iconsColumn2 = [
    const Icon(Icons.star),
    const Icon(Icons.star),
    const Icon(Icons.all_inclusive),
    const Icon(Icons.alarm_add),
    const Icon(Icons.alarm_off),
  ];

  final List<String> _titlesColumn2 = [
    'Airplane Ticket',
    'Album',
    'All Inclusive',
    'Alarm Add',
    'Alarm Off',
  ];

  void _selectContainer(int index, int column) {
    setState(() {
      if (column == 1) {
        if (_selectedContainerIndices1.contains(index)) {
          _selectedContainerIndices1.remove(index);
        } else {
          _selectedContainerIndices1.add(index);
          _storeSelectedItem(index, column);
        }
      } else {
        if (_selectedContainerIndices2.contains(index)) {
          _selectedContainerIndices2.remove(index);
        } else {
          _selectedContainerIndices2.add(index);
          _storeSelectedItem(index, column);
        }
      }
    });
  }

  Future<void> _storeSelectedItem(int index, int column) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('selectedItems').add({
        'index': index,
        'column': column,
        'timestamp': Timestamp.now(),
      });
      print('Selected item stored successfully.');
    } catch (e) {
      print('Error storing selected item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Selection Screen'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.00),
            child: Column(
              children: [
                Text(
                  'What Are Your Interests?',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "This will help us recommend items to you.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainerColumn(screenWidth * 0.4, 1),
              _buildContainerColumn(screenWidth * 0.4, 2),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // if (_selectedContainerIndices1.isNotEmpty &&
                  //     _selectedContainerIndices2.isNotEmpty) {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomeScreenMain(user: APIs.me,)),
                  //   );
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text(
                  //       'Please select at least one container in each column.',
                  //     ),
                  //   ));
                  // }
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainerColumn(double containerWidth, int column) {
    final double containerSize = containerWidth * 0.45;

    List<int> selectedContainers =
        column == 1 ? _selectedContainerIndices1 : _selectedContainerIndices2;

    List<Widget> iconsList = column == 1 ? _iconsColumn1 : _iconsColumn2;
    List<String> titlesList = column == 1 ? _titlesColumn1 : _titlesColumn2;

    return Column(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () => _selectContainer(index, column),
          child: Container(
            width: containerSize,
            height: containerSize,
            margin: EdgeInsets.all(containerWidth * 0.025),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedContainers.contains(index)
                    ? Colors.purple
                    : Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(containerWidth * 0.05),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconsList[index],
                SizedBox(height: containerWidth * 0.025),
                Text(
                  titlesList[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedContainers.contains(index)
                        ? Colors.purple
                        : Colors.black,
                    fontSize: containerWidth * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
