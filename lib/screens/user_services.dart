import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  List<int> selectedCategoryIndices = [];
  List<Map<String, dynamic>> services = [
    {"category": "Jump Start", "price": 50.0, "image": "lib/assets/jump_start.png"},
    {"category": "Full Service", "price": 100.0, "image": "lib/assets/checklist.png"},
    {"category": "Towing", "price": 75.0, "image": "lib/assets/towing.jpg"},
    {"category": "Petrol", "price": 30.0, "image": "lib/assets/petrol.png"},
    {"category": "Minimum Estimated Cost", "price": 20.0, "image": "lib/assets/estimate.png"},
  ];

  double calculateTotalPrice() {
    double total = 0.0;
    for (int index in selectedCategoryIndices) {
      total += services[index]["price"];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Services'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: services.length + 1, // Add 1 for the image above categories
              itemBuilder: (context, index) {
                if (index == 0) {
                 
                  return Image.asset(
                    "lib/assets/mech.jpg",
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  );
                } else {
                  // Displaying the categories
                  index--; // Adjust index for services list
                  return Card(
                    color: selectedCategoryIndices.contains(index) ? Colors.blue : null,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          if (selectedCategoryIndices.contains(index)) {
                            selectedCategoryIndices.remove(index);
                          } else {
                            selectedCategoryIndices.add(index);
                          }
                        });
                      },
                      leading: Image.asset(
                        services[index]["image"],
                        width: 50.0, // Adjust width as needed
                        height: 50.0, // Adjust height as needed
                      ),
                      title: Text(
                        services[index]["category"],
                        style: TextStyle(fontSize: 22.0),
                      ),
                      subtitle: Text(
                        'Price: \$${services[index]["price"]}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (selectedCategoryIndices.isNotEmpty)
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      // Navigate to another page if needed
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ServiceList(),
  ));
}
