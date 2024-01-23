from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

categories_data = [
    {
        'id': 1,
        'name': 'Electronics',
        'info': 'Electronics products',
    },
    {
        'id': 2,
        'name': 'Cloths',
        'info': 'Cloths products',
    },
    {
        'id': 3,
        'name': 'Books',
        'info': 'Books products',
    },
    {
        'id': 4,
        'name': 'Plants',
        'info': 'Plants products',
    },
]

products_data = [
    {'id': 1, 'name': 'Smartphone', 'price': 999.99, 'category_id': 1},
    {'id': 2, 'name': 'Laptop', 'price': 1499.99, 'category_id': 1},
    {'id': 3, 'name': 'T-Shirt', 'price': 19.99, 'category_id': 2},
    {'id': 4, 'name': 'Jeans', 'price': 39.99, 'category_id': 2},
    {'id': 5, 'name': 'Science Fiction', 'price': 29.99, 'category_id': 3},
    {'id': 6, 'name': 'Mystery', 'price': 24.99, 'category_id': 3},
]

orders_data = [
    {
        'id': 1,
        'total_value': 124.98,
        'order_date': '2023-01-01',
        'order_status': 'PROCESSING',
        'products': [1, 3],
    },
    {
        'id': 2,
        'total_value': 79.98,
        'order_date': '2023-01-02',
        'order_status': 'SHIPPED',
        'products': [2, 4],
    },
    {
        'id': 3,
        'total_value': 1594.96,
        'order_date': '2023-09-12',
        'order_status': 'SEND',
        'products': [2, 4, 5, 6],
    },
]

@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories_data)

@app.route('/category/<int:category_id>/products', methods=['GET'])
def get_products_for_category(category_id):
    category_products = [product for product in products_data if product['category_id'] == category_id]
    return jsonify(category_products)

@app.route('/orders', methods=['GET'])
def get_orders():
    return jsonify(orders_data)

@app.route('/orders', methods=['POST'])
def add_order():
    try:
        data = request.get_json()
        print(data)
        card_number = data.get('card_number')
        ccv = data.get('ccv')
        orders = data.get('orders', {})
        
        print(f"Making payment for card: {card_number}, ccv {ccv}")
        print(orders)
        
        new_order_products = []
        for product_id, quantity in orders.items():
            for _ in range(quantity):
                new_order_products.append(product_id)
        
        new_order = {
            'id': len(orders_data) + 1,
            'total_value': calculate_total_value(orders),
            'order_date': get_current_date(),
            'order_status': 'PROCESSING',  
            'products': new_order_products
        }

        orders_data.append(new_order)
        return jsonify(new_order), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
def calculate_total_value(orders):
    total_value = 0.0

    for product_id, quantity in orders.items():
        product = next((p for p in products_data if p['id'] == int(product_id)), None)
        if product:
            total_value += float(product['price']) * quantity

    return round(total_value, 2)

def get_current_date():
    return datetime.now().strftime('%Y-%m-%d')

@app.route('/product', methods=['POST'])
def add_product():
    try:
        data = request.get_json()
        
        name = data.get('name')
        price = data.get('price')
        category_id = data.get('category_id')
        
        new_product = {
            'id': len(products_data) + 1,
            'name': name,
            'price': price,
            'category_id': category_id
        }

        products_data.append(new_product)

        return jsonify(new_product['id']), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
