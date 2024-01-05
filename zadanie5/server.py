from flask import Flask, request, jsonify

app = Flask(__name__)

users_db = [
    {"username": "admin", "password": "admin123", "first_name": "Admin", "last_name": "Smith"},
    {"username": "user1", "password": "password1", "first_name": "John", "last_name": "Doe"},
]

token_db = {}

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    for user in users_db:
        if user['username'] == username and user['password'] == password:
            print(user)
            return jsonify({"username": user['username'], "firstName": user['first_name'], "lastName": user['last_name']}), 200

    return jsonify({"message": "Invalid credentials"}), 401

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    first_name = data.get('first_name')
    last_name = data.get('last_name')

    for user in users_db:
        if user['username'] == username:
            return jsonify({"message": "Username already exists"}), 400

    new_user = {"username": username, "password": password, "first_name": first_name, "last_name": last_name}
    users_db.append(new_user)
    print(new_user)
    return jsonify({"username": new_user['username'], "firstName": new_user['first_name'], "lastName": new_user['last_name']}), 201

@app.route('/token', methods=['POST'])
def save_token():
    data = request.get_json()
    id = data.get('id')
    token = data.get('token')

    token_db[id] = token
    return jsonify({"message": "Token saved successfully"}), 201

if __name__ == '__main__':
    app.run(debug=True)
