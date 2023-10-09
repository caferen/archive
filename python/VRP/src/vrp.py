from __future__ import print_function
from math import ceil
from data_model import create_distance_matrix
from ortools.constraint_solver import pywrapcp


def format_solution(routing, manager, solution, data, atm_details):
    plan_output = {}

    for vehicle_id in range(data["num_vehicles"]):
        index = routing.Start(vehicle_id)
        plan_output[vehicle_id] = []
        liste = [-1] + atm_details['atmNo'].tolist() + [-1]
        while not routing.IsEnd(index):
            node = liste[manager.IndexToNode(index)]

            if node != -1:
                plan_output[vehicle_id].append(node)

            index = solution.Value(routing.NextVar(index))
   
    return plan_output


def solve_for_routes(vehicle_count, coordinates, strategy, heuristic):
    data = {
        'distance_matrix': create_distance_matrix(coordinates[['coordinateX', 'coordinateY']]),
        'num_vehicles': vehicle_count,
        'depot': 0,
    }

    manager = pywrapcp.RoutingIndexManager(len(data['distance_matrix']),
                                           data['num_vehicles'], data['depot'])

    routing = pywrapcp.RoutingModel(manager)

    def distance_callback(from_index, to_index):
        from_node = manager.IndexToNode(from_index)
        to_node = manager.IndexToNode(to_index)
        return data['distance_matrix'][from_node][to_node] + 500

    transit_callback_index = routing.RegisterTransitCallback(distance_callback)

    routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

    routing.AddDimension(
        transit_callback_index,
        0,  # no slack
        9223372036854775807,  # vehicle maximum travel distance
        True,  # start cumul to zero
        'Distance')
    distance_dimension = routing.GetDimensionOrDie('Distance')
    distance_dimension.SetGlobalSpanCostCoefficient(100)

    search_parameters = pywrapcp.DefaultRoutingSearchParameters()
    search_parameters.first_solution_strategy = (strategy)
    search_parameters.local_search_metaheuristic = (heuristic)
    search_parameters.time_limit.FromSeconds(90)

    solution = routing.SolveWithParameters(search_parameters)

    result = format_solution(routing, manager, solution, data, coordinates[[
                             'atmNo']]) if solution else {'Error': 'Solution not found!'}

    return result
