from flask import Flask, request
from waitress import serve
from main import main
import traceback


app = Flask(__name__)


@app.route('/route', methods=['POST'])
def calculate_routes():
    try:
        app.config['JSON_AS_ASCII'] = False
        params = request.get_json()

        pools = params['pools']

        try:
            workday = params['day']

            if workday not in [5, 6]:
                return {"Error": "Invalid parameters"}, 400
        except:
            workday = 6

        if type(pools) != list:
            return {"Error": "Invalid parameters"}, 400

        for pool in pools:
            if type(pool) != str:
                return {"Error": "Invalid parameters"}, 400

        print("Calculating routes with paramaters: \n\tpool: ",
              pools)
    except Exception:
        traceback.print_exc()
        return {"Error": "Internal server error before calculating routes"}, 500
    else:
        try:
            resp = main(
                pools, workday, "LOCAL_CHEAPEST_INSERTION", "GUIDED_LOCAL_SEARCH")
            return resp, 200 if 'Error' not in resp else 500
        except Exception:
            traceback.print_exc()
            return {"Error": "Internal server error while calculating routes"}, 500


if __name__ == '__main__':
    serve(app, host='0.0.0.0', port=8080, threads=1)
