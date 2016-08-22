from flask import Flask, jsonify, g, request

app = Flask(__name__)

@app.route('/rate-limited')
def index():
    return jsonify({'response':'This is a rate limited response'})   

if __name__ == '__main__':
    app.debug = True
    app.run(host = '0.0.0.0', port = 5000)
