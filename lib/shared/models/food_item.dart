class FoodItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final String category;
  final List<String> tags;
  final bool isPopular;
  final int preparationTime; // in minutes

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.category,
    required this.tags,
    this.isPopular = false,
    required this.preparationTime,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
      isPopular: json['isPopular'] ?? false,
      preparationTime: json['preparationTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'category': category,
      'tags': tags,
      'isPopular': isPopular,
      'preparationTime': preparationTime,
    };
  }
}

class CartItem {
  final FoodItem foodItem;
  int quantity;
  final List<String> selectedOptions;
  final String specialInstructions;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
    this.selectedOptions = const [],
    this.specialInstructions = '',
  });

  double get totalPrice => foodItem.price * quantity;
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String status;
  final DateTime orderDate;
  final String deliveryAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.orderDate,
    required this.deliveryAddress,
    required this.paymentMethod,
  });
}

class Voucher {
  final String id;
  final String title;
  final String description;
  final String code;
  final double discountValue;
  final String discountType; // 'percentage' or 'fixed'
  final double minOrderValue;
  final DateTime expiryDate;
  final String imageUrl;
  final bool isUsed;

  const Voucher({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.discountValue,
    required this.discountType,
    required this.minOrderValue,
    required this.expiryDate,
    required this.imageUrl,
    this.isUsed = false,
  });
}

class Location {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final bool isDefault;

  const Location({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
  });
}