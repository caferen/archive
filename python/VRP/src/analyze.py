from xlwt import Workbook
import json
from ortools.constraint_solver import routing_enums_pb2

heuristics = {
    "GREEDY_DESCENT": routing_enums_pb2.LocalSearchMetaheuristic.GREEDY_DESCENT,
    "SIMULATED_ANNEALING": routing_enums_pb2.LocalSearchMetaheuristic.SIMULATED_ANNEALING,
    "GUIDED_LOCAL_SEARCH": routing_enums_pb2.LocalSearchMetaheuristic.GUIDED_LOCAL_SEARCH,
    "TABU_SEARCH": routing_enums_pb2.LocalSearchMetaheuristic.TABU_SEARCH,
    "GENERIC_TABU_SEARCH": routing_enums_pb2.LocalSearchMetaheuristic.GENERIC_TABU_SEARCH
}

strategies = {
    "PATH_CHEAPEST_ARC": routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC,
    "SAVINGS": routing_enums_pb2.FirstSolutionStrategy.SAVINGS,
    "CHRISTOFIDES": routing_enums_pb2.FirstSolutionStrategy.CHRISTOFIDES,
    "PARALLEL_CHEAPEST_INSERTION": routing_enums_pb2.FirstSolutionStrategy.PARALLEL_CHEAPEST_INSERTION,
    "SEQUENTIAL_CHEAPEST_INSERTION": routing_enums_pb2.FirstSolutionStrategy.SEQUENTIAL_CHEAPEST_INSERTION,
    "LOCAL_CHEAPEST_INSERTION": routing_enums_pb2.FirstSolutionStrategy.LOCAL_CHEAPEST_INSERTION,
    "GLOBAL_CHEAPEST_ARC": routing_enums_pb2.FirstSolutionStrategy.GLOBAL_CHEAPEST_ARC,
    "LOCAL_CHEAPEST_ARC": routing_enums_pb2.FirstSolutionStrategy.LOCAL_CHEAPEST_ARC,
    "FIRST_UNBOUND_MIN_VALUE": routing_enums_pb2.FirstSolutionStrategy.FIRST_UNBOUND_MIN_VALUE,
}


directory = ""

wb = Workbook()

sheet = wb.add_sheet("Analysis")

i = 1
j = 1

for strategy in strategies:

    sheet.write(i, 0, strategy)

    i += 1

for heuristic in heuristics:
    heuristic = heuristic.split(".", 1)[0]

    sheet.write(0, j, heuristic)

    j += 1

i = 1
for strategy in strategies:
    j = 1

    for heuristic in heuristics:
        filename = f"../{directory}/{strategy}/{heuristic}.json"
        with open(filename, 'r') as file:
            data = json.load(file)
        weekly_distance = 0
        load_of_gazikilicaslan = 0
        distance_of_gazikilicaslan = 0
        load_of_hayrettingunduz = 0
        distance_of_hayrettingunduz = 0
        for d in data:
            key = list(data[d].keys())[0]

            weekly_distance += data[d][key]["min_distance"]
            load_of_gazikilicaslan += data[d][key]["min_time_heuristic"]["Load of gazikilicaslan"]
            distance_of_gazikilicaslan += data[d][key]["min_time_heuristic"]["Distance of gazikilicaslan"]
            load_of_hayrettingunduz += data[d][key]["min_time_heuristic"]["Load of hayrettingunduz"]
            distance_of_hayrettingunduz += data[d][key]["min_time_heuristic"]["Distance of hayrettingunduz"]

        result = {
            "weekly_distance": weekly_distance,
            "load_diff": load_of_gazikilicaslan - load_of_hayrettingunduz,
            "distance_diff": distance_of_gazikilicaslan - distance_of_hayrettingunduz,
        }
        sheet.write(i, j, result["weekly_distance"])
        sheet.write(i + 10, j, result["load_diff"])
        sheet.write(i + 20, j, result["distance_diff"])
        j += 1

    i += 1

wb.save(f"../{directory}/Analysis.xls")
