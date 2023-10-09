import multiprocessing
import pandas as pd
import json
from data_model import create_clusters
from vrp import solve_for_routes
from db import connect_to_database
from benchmark import benchmark, heuristics, strategies


def convert_to_named(plan, days, team):
    named_plan = {i: {} for i in range(days)}
    for daily_plan in plan:
        for route in plan[daily_plan]:
            if route == "Error":
                continue
            named_plan[daily_plan][team[route]] = plan[daily_plan][route]

    return named_plan


def worker(day, queue, team, daily_jobs, strategy, heuristic):
    initial_solution = solve_for_routes(
        len(team), daily_jobs[day], strategy, heuristic)
    queue.put([day, initial_solution])


# @benchmark
def main(pools, workday, strategy, heuristic):
    strategy = strategies[strategy]
    heuristic = heuristics[heuristic]
    queue = multiprocessing.SimpleQueue()

    processes = []

    # Get team details from the database and merge them
    team_data = connect_to_database(pools)[1]
    team = []
    for data in team_data:
        team += data["users"]

    # Divide weekly jobs into days
    daily_jobs = create_clusters(workday, pools)

    # Plan shell
    plan = {i: {} for i in range(workday)}

    for day in daily_jobs:
        if not daily_jobs[day].empty:
            processes.append(
                multiprocessing.Process(target=worker, args=(day, queue, team, daily_jobs, strategy, heuristic)))

    for process in processes:
        process.start()

    for _ in processes:
        q = queue.get()
        plan[q[0]] = q[1]

    named_plan = convert_to_named(plan, workday, team)

    return named_plan


if __name__ == "__main__":
    with open("./2.json", 'w') as file:
        json.dump(main(["ANKARA-2"], 6, "LOCAL_CHEAPEST_INSERTION",
                  "GUIDED_LOCAL_SEARCH"), file, ensure_ascii=True, indent=4)
