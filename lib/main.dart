import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 15),
    Product(name: 'Product 4', price: 20),
    Product(name: 'Product 5', price: 20),
    Product(name: 'Product 6', price: 20),
    Product(name: 'Product 7', price: 20),
    Product(name: 'Product 8', price: 20),
    Product(name: 'Product 9', price: 20),
    Product(name: 'Product 10', price: 20),
    Product(name: 'Product 11', price: 20),
    Product(name: 'Product 12', price: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),

        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(products)),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Product List'),

      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: ProductCounter(
              product: products[index],
              onCounterUpdated: (product) {
                if (product.counter == 5) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You\'ve bought 5 ${product.name}!'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter = 0;

  Product({required this.name, required this.price});
}

class ProductCounter extends StatefulWidget {
  final Product product;
  final Function(Product) onCounterUpdated;

  ProductCounter({required this.product, required this.onCounterUpdated});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Quantity: ${widget.product.counter}'),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.product.counter++;
            });
            widget.onCounterUpdated(widget.product);
          },
          child: Text('Buy Now'),
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  int getTotalCount() {
    int totalCount = 0;
    for (var product in products) {
      totalCount += product.counter;
    }
    return totalCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Text('Total Items in Cart: ${getTotalCount()}'),
      ),
    );
  }
}
