from flask import jsonify, Flask, request
from os import environ
from socket import gethostname

app = Flask(__name__)
FLASK_PORT = environ.get('PORT_NUMBER')

@app.route('/')
def root():
    headers_list = ['Flask hostname', gethostname()]
    headers_list.append(request.headers.to_list())
    print (headers_list)
    return jsonify( headers_list )


if __name__ == '__main__':
    app.run(port=FLASK_PORT, host='0.0.0.0', debug=True)