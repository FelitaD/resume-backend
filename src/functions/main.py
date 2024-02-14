#!/usr/bin/env python3

import functions_framework
from flask import jsonify
from google.cloud import datastore

PROJECT = 'resume-404711'

@functions_framework.http
def update_visitor_count(request):
    if request.method == "OPTIONS":
        # Allows GET requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": ["GET", "POST"],
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Max-Age": "3600",
        }

        return ("", 204, headers)
    
    if request.method == "GET" or request.method == "POST":
        # Connect to Firestore in datastore mode
        client = datastore.Client(project=PROJECT)
        entity_key = client.key('visitors', 5634161670881280)
        # Get current visitor count and increment it
        visitors = client.get(entity_key)
        new_count = visitors['count'] + 1 
        # Put new value in database
        visitors.update(
            {'count': new_count}
        )
        client.put(visitors)
        # Return response
        response = jsonify({'count': new_count})
        response.headers.set('Access-Control-Allow-Origin', '*')
        response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
        return response
    
    else:
        return "Method not allowed ", 401