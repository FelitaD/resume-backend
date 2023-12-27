import os

from flask import Flask, request
from flask_cors import CORS
from google.cloud import datastore

app = Flask(__name__)
CORS(app)

def create_datastore_client(project_id):
    """Create client for Firestore in Datastore mode."""
    return datastore.Client(project_id)

@app.route("/hello", methods=['GET'])
def hello():
    """Say hello."""
    if request.method == 'GET':
        name = os.environ.get("NAME", "World")
        return f"Hello {name}!"

@app.route("/update_visitor_count", methods=['POST'])
def update_visitor_count():
    """Update visitors count in Firestore in Datastore mode."""
    if request.method == 'POST':
        client = create_datastore_client('resume-404711')
        visitor_count = int(request.form['visitor_count'])
        key = client.key('visitors', 5634161670881280)
        visitors = client.get(key)
        new_count = visitors['count'] + visitor_count
        visitors.update(
            {'count': new_count}
        )
        client.put(visitors)
        return f"Successfully added a visitor, {visitors.key}"

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
