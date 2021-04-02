from flask import jsonify, Flask, request
from os import environ
from socket import gethostname
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)
FLASK_PORT = environ.get('PORT_NUMBER', 5000)

@app.route('/')
def root():
    headers_list = [['Flask hostname', gethostname()]]
    for i in request.headers.items():
        headers_list.append(i)
    print (headers_list)
    return jsonify( headers_list )


if __name__ == '__main__':
    app.run(port=FLASK_PORT, host='0.0.0.0', debug=True)
