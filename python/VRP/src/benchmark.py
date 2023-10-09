from ortools.constraint_solver import routing_enums_pb2
import time
import json
import os

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


def benchmark(solver):
    def wrapper(*args, **kwargs):
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
        pools = args[0]
        workday = args[1]
        strategy = args[2]
        heuristic = args[3]
        filename = f"../{pools}_{workday}/{strategy}/{heuristic}.json"
        team = ["gazikilicaslan", "hayrettingunduz"]
        time1 = time.time()

        print(f"Strategy: {strategy} \nHeuristic: {heuristic}")
        sol = solver(*args, **kwargs)
        time2 = (time.time()-time1) * 1000
        print(f"Time: {time2}")

        if "Error" in sol:
            return

        res = {i: {s: {} for s in strategies}
               for i in range(6)}

        for solution in sol:
            dist = 0
            for person in team:
                dist += sol[solution][person
                                      ]["distance"] if person in sol[solution] else 0

            res[solution][strategy][heuristic] = {
                "time": time2,
                "total_distance": dist,
            }

            for person in team:
                res[solution][strategy][heuristic][f"Load of {person}"] = sol[
                    solution][person]["load"] if person in sol[solution] else 0
                res[solution][strategy][heuristic][f"Distance of {person}"] = sol[
                    solution][person]["distance"] if person in sol[solution] else 0

        analysis = {i: {strategy: {} for strategy in strategies}
                    for i in range(6)}

        for day in res:
            for strategy in res[day]:
                analysis[day][strategy]['min_time'] = 1000000000000000000
                analysis[day][strategy]['min_distance'] = 1000000000000000
                for heuristic in res[day][strategy]:
                    if res[day][strategy][heuristic]['time'] < analysis[day][strategy]['min_time']:
                        analysis[day][strategy]['min_time'] = res[day][strategy][heuristic]['time']
                        analysis[day][strategy]['min_time_heuristic'] = {
                            "heuristic": heuristic,
                            "distance": res[day][strategy][heuristic]['total_distance'],
                            "time": res[day][strategy][heuristic]['time'],
                        }

                        for person in team:
                            analysis[day][strategy]['min_time_heuristic'][f"Load of {person}"] = res[
                                day][strategy][heuristic][f"Load of {person}"]
                            analysis[day][strategy]['min_time_heuristic'][f"Distance of {person}"] = res[
                                day][strategy][heuristic][f"Distance of {person}"]

                    if res[day][strategy][heuristic]['total_distance'] < analysis[day][strategy]['min_distance']:
                        analysis[day][strategy]['min_distance'] = res[day][strategy][heuristic]['total_distance']
                        # Use this if time is also benchmarked
                        if analysis[day][strategy]['min_time_heuristic']['heuristic'] != heuristic:
                            analysis[day][strategy]['min_distance_heuristic'] = {
                                "heuristic": heuristic,
                                "distance": res[day][strategy][heuristic]['total_distance'],
                                "time": res[day][strategy][heuristic]['time'],
                            }

                            for person in team:
                                analysis[day][strategy]['min_distance_heuristic'][
                                    f"Load of {person}"] = res[day][strategy][heuristic][f"Load of {person}"]
                                analysis[day][strategy]['min_distance_heuristic'][f"Distance of {person}"] = res[
                                    day][strategy][heuristic][f"Distance of {person}"]

                if analysis[day][strategy]['min_time'] == 1000000000000000000:
                    del analysis[day][strategy]

        os.makedirs(os.path.dirname(filename), exist_ok=True)

        with open(filename, 'w') as file:
            json.dump(analysis, file, ensure_ascii=True, indent=4)

    return wrapper
