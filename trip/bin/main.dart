import 'dart:io';
import 'dart:convert';

class Trip {
     int _id = 0;
  String _location;
  int _passengerLimit;
  String _date;
  double _price;
   List allTrips = [];
   List passengers = [];

   
  Trip();

  int get getId {
    return _id;
  }
  String get getLocation {
    return _location;
  }
  int get getPassengerLimit {
    return _passengerLimit;
  }
  String get getDate {
    return _date;
  }

  double get getPrice {
    return _price;
  }

  set setId(int id) {
    _id = id;
  }

  set setLocation(String location) {
    _location = location;
  }

  set setPassengerLimit(int pl) {
    _passengerLimit = pl;
  }

  set setDate(String date) {
    _date = date;
  }

  set setPrice(double price) {
    _price = price;
  }

  void addTrip(
     var id,
    String location,
    int passengerLimit,
    String date,
    double price,
  ) {
  

    var trip =
        '{ "id" : "$id" , "location" : "$location" , "passengerLimit": "$passengerLimit" , "date": "$date" , "price": "$price" }';
    var tripMap = jsonDecode(trip);
    print('Trip is Added Sucessfully');
    allTrips.add(tripMap);
  }

  void editTrip(int id) {
    var flag = 0;
    for (var trip in allTrips) {
      if (trip.containsKey('id')) {
        if (int.parse(trip['id']) == id) {
          flag = 1;
        }
      }
    }
    if (flag == 0) {
      print('id doesnt match with any trip');
    } else if (flag == 1) {
      print('enter new trip location: ');
      var location = stdin.readLineSync();
      print('enter new trip date: ');
      var date = stdin.readLineSync();
      print('enter new trip price: ');
      var price = double.parse(stdin.readLineSync());
      print('enter new max trip number');
      var passengerLimit = int.parse(stdin.readLineSync());
      allTrips.forEach((ee) {
        if (int.parse(ee['id']) == id) {
          ee['id'] = '$id';
          ee['location'] = '$location';
          ee['passengerLimit'] = '$passengerLimit';
          ee['date'] = '$date';
          ee['price'] = '$price';
          print(' Edited Sucessfully');
        }
      });
    }
  }

  void deleteTrip(int id) {
    var flag = 0;
    var dindex;

     for (var trip in allTrips) {
     if (trip.containsKey('id')) {
        if (int.parse(trip['id']) == id) {
          flag = 1;
          trip.clear();
        }
       }
     }
 
  }

  void viewTrips() {
    if (allTrips.isEmpty) {
      print('there is no trips');
    } else {
      print('Our Trips :');
      allTrips.forEach((item) {
        print(item);
      });
    }
  }

  void searchTrips(double price) {
    var searchResult = [];
    for (var trip in allTrips) {
      if (double.parse(trip['price']) == price) {
        searchResult.add(trip);
      }
    }
    if (searchResult.isEmpty) {
      print('there is no trip with this price');
    } else {
      searchResult.forEach((item) {
        print(item);
      });
    }
  }
  void reserveTrip(int id) {
    var flag = 0;
    for (var trip in allTrips) {
      if (trip.containsKey('id')) {
        if (int.parse(trip['id']) == id) {
          flag = 1;
        }
      }
    }
    if (flag == 0) {
      print('id doesnt match with any trip');
    } else if (flag == 1) {
      for (var trip in allTrips) {
        if (int.parse(trip['id']) == id) {
          if (int.parse(trip['passengerLimit']) > 0) {
            print('the trip is available for reservation');
            print('please fill this application to complete reservation');
            print('enter your name ');
            var name = stdin.readLineSync();
            print('enter your social security number ');
            var ssn = stdin.readLineSync();
            print('enter yoour phone number');
            var pnumber = stdin.readLineSync();
            print('enter payement method (visa/mastercard)');
            var pay = stdin.readLineSync();
            var newPS = int.parse(trip['passengerLimit']);
            --newPS;
            trip['passengerLimit'] = '$newPS';
            var idd = trip['id'];
            var passenger =
                '{ "tripid" : "$idd" , "name" : "$name" , "ssn": "$ssn" , "phoneNumber": "$pnumber" , "paymentMethod": "$pay" }';
            var passengerMap = jsonDecode(passenger);
            passengers.add(passengerMap);
            print('the trip is reserved sucessfully');
            if (double.parse(trip['price']) > 10000) {
              var bonus = double.parse(trip['price']) * 0.8;
              print('you got the bonus and u have to pay only $bonus');
            }
          } else {
            print('the trip is full');
          }
        }
      }
    }
  }

  void viewLatestTrips() {
    if (allTrips.isEmpty) {
      print('there is no trips');
    } else if (allTrips.length <= 10 && allTrips.isNotEmpty) {
      print('last added trips : ');

      for (var i = 0; i < allTrips.length; i++) {
        print(allTrips[i]);
      }
    } else if (allTrips.length > 10) {
      var lastTen = allTrips.length - 10;
      print('last added trips : ');
      for (var i = lastTen; i < allTrips.length; i++) {
        print(allTrips[i]);
      }
    }
  }

  void viewAllPassengers() {
    if (passengers.isNotEmpty) {
      passengers.forEach((item) {
        print(item);
      });
    } else {
      print('there isnt any passengers');
    }
  }

  void viewPassenger(int tripID) {
    var searchResult = [];

    for (var passenger in passengers) {
      if (int.parse(passenger['tripid']) == tripID) {
        searchResult.add(passenger);
      }
    }
    if (searchResult.isEmpty) {
      print('there isnt any passengers on this trip yet');
    } else {
      searchResult.forEach((item) {
        print(item);
      });
    }
  }
}

void main() {
  var switchh = true;
  while (switchh == true) {
    print('hi this travelco agency');
    print('1- add a new trip');
    print('2- edit trip');
    print('3- delete trip');
    print('4- search trip by price');
    print('5- reserve a trip');
    print('6- last added trips');
    print('7- view passengers');
  
    print('please select the number of your choice  from the above menu: ');
    var choice = int.parse(stdin.readLineSync());

    switch (choice) {
      case 1:
        {
          print('---------- Add Trip--------------- ');
          print('enter trip iD  : ');
          var id = stdin.readLineSync();
          print('enter trip price : ');
          var price = double.parse(stdin.readLineSync());
          if(price>=10000){
            price=price-(price*20/100)
          }
          print('enter trip date : ');
          var date = stdin.readLineSync();
          print('enter trip location: ');
          var location = stdin.readLineSync();
          print('enter passengers limit  ');
          var passengers = int.parse(stdin.readLineSync());
          var trip = Trip();
          trip.addTrip(id,location, passengers, date, price);
        }

        break;
      case 2:
        {
          var t2 = Trip();
          t2.viewTrips();
          print('Enter id to edit trip: ');
          var id = int.parse(stdin.readLineSync());
          t2.editTrip(id);
        }
        break;
     
      case 3:
        {
          var t3 = Trip();
          t3.viewTrips();
          print('Enter trip id : ');
          var id = int.parse(stdin.readLineSync());
          t3.deleteTrip(id);
          print('delete Done : ');
        }
        break;
      case 4:
        {
          var t4 = Trip();
          t4.viewTrips();
        }
        break;
      case 5:
        {
          var t5 = Trip();
          print('Enter the preice of trips : ');
          var price = double.parse(stdin.readLineSync());
          t5.searchTrips(price);
        }
        break;
      case 6:
        {
          var t6 = Trip();
          t6.viewTrips();
           print('reserve  trip');
          var id = int.parse(stdin.readLineSync());
          t6.reserveTrip(id);
        }

        break;

      case 7:
        {
          var t7 = Trip();
          t7.viewLatestTrips(); 
        }
        break;
      case 8:
        {
          var t8 = Trip();
        t8.viewAllPassengers();
        }
        break;
      default:
        {
          print('Invalid choice');
        }
    }
  }
}