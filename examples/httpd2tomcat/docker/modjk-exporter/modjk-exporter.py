from flask import Flask, Response
from prometheus_client import Gauge, generate_latest, CONTENT_TYPE_LATEST
import xml.etree.ElementTree as ET
import requests

app = Flask(__name__)

# Define metrics
ajp_used = Gauge('modjk_ajp_used', 'Number of used connections')
ajp_errors = Gauge('modjk_ajp_errors', 'Number of error connections')
ajp_client_errors = Gauge('modjk_ajp_client_errors', 'Client error count')
ajp_transferred = Gauge('modjk_ajp_transferred', 'Bytes transferred')
ajp_read = Gauge('modjk_ajp_read', 'Bytes read')
ajp_busy = Gauge('modjk_ajp_busy', 'Busy connections')
ajp_max_busy = Gauge('modjk_ajp_max_busy', 'Max busy connections')
ajp_connected = Gauge('modjk_ajp_connected', 'Currently connected')
ajp_max_connected = Gauge('modjk_ajp_max_connected', 'Max ever connected')

@app.route('/metrics')
def metrics():
    try:
        response = requests.get("http://127.0.0.1/jk-watch?mime=xml", timeout=5)
        response.raise_for_status()
    except requests.RequestException as e:
        return Response(f"# Error fetching mod_jk status: {e}", mimetype='text/plain')

    try:
        root = ET.fromstring(response.content)
        ajp = root.find(".//{http://tomcat.apache.org}ajp")
        if ajp is not None:
            ajp_used.set(int(ajp.attrib.get('used', 0)))
            ajp_errors.set(int(ajp.attrib.get('errors', 0)))
            ajp_client_errors.set(int(ajp.attrib.get('client_errors', 0)))
            ajp_transferred.set(int(ajp.attrib.get('transferred', 0)))
            ajp_read.set(int(ajp.attrib.get('read', 0)))
            ajp_busy.set(int(ajp.attrib.get('busy', 0)))
            ajp_max_busy.set(int(ajp.attrib.get('max_busy', 0)))
            ajp_connected.set(int(ajp.attrib.get('connected', 0)))
            ajp_max_connected.set(int(ajp.attrib.get('max_connected', 0)))
    except ET.ParseError as e:
        return Response(f"# XML parsing error: {e}", mimetype='text/plain')

    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9114)