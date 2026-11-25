import os
import socket

from flask import Flask, jsonify

app = Flask(__name__)
APP_VERSION = os.environ.get("APP_VERSION", "v1.0.1")


@app.route("/")
def index():
    return jsonify(
        {
            "hostname": socket.gethostname(),
            "version": APP_VERSION,
            "message": "Hello from gallery-app",
        }
    )


@app.route("/health")
def health():
    return "OK", 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
