from flask import Flask, jsonify

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

@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories_data)

@app.route('/category/<int:category_id>/products', methods=['GET'])
def get_products_for_category(category_id):
    category_products = [product for product in products_data if product['category_id'] == category_id]
    return jsonify(category_products)

if __name__ == '__main__':
    app.run(debug=True)
