import pandas as pd
from scipy.spatial.distance import cdist
import pandas as pd
import numpy as np
import haversine
from db import connect_to_database
from math import ceil
from sklearn.cluster import DBSCAN


def merge(coords, eps):
    if coords.empty:
        return pd.Series(dtype="float64")

    kms_per_radian = 6371.0088

    epsilon = eps / kms_per_radian
    db = DBSCAN(eps=epsilon, min_samples=1, algorithm='ball_tree',
                metric='haversine').fit(np.radians(coords[["coordinateY", "coordinateX"]]))
    cluster_labels = db.labels_
    num_clusters = len(set(cluster_labels))
    clusters = pd.Series([coords[cluster_labels == n]
                          for n in range(num_clusters)])

    return clusters


def appoint_to_days(merged_cluster, workday, daily_assignments):

    def get_best_day(days=[k for k in range(workday)]):
        lenghts = {
            j: len(daily_assignments[j].index) for j in days
        }

        return min(lenghts, key=lenghts.get)

    def get_best_group(groups, days=[k for k in range(workday)]):
        lenghts = {
            j: len(daily_assignments[j].index) for j in days
        }

        group_lengths = {}

        for group in groups:
            length = 0
            for day in group:
                length += lenghts[day]
            group_lengths[group] = length

        return min(group_lengths, key=group_lengths.get)

    for i in merged_cluster.index:
        df = merged_cluster[i]

        new_nodes = []
        for j in df.index:
            new_nodes.append({'atmNo': df.at[j, 'atmNo'],
                              'coordinateY': df.at[j, 'coordinateY'],
                              'coordinateX': df.at[j, 'coordinateX']})

        best_day = get_best_day(),
        best_day = best_day[0]

        if workday == 5:
            if df['totalProcccesPerMonth'].values[0] == 3:
                group = [0, 2, 4]
                for new_node in new_nodes:
                    for k in group:
                        daily_assignments[k].append(
                            new_node, ignore_index=True, sort=False)

            elif df['totalProcccesPerMonth'].values[0] == 2:
                if best_day <= 3:
                    first_day = best_day
                else:
                    first_day = 3
                for new_node in new_nodes:
                    daily_assignments[first_day] = daily_assignments[first_day].append(
                        new_node, ignore_index=True, sort=False)

                next_best_day = get_best_day(
                    range(first_day + 2, workday)) if first_day != 3 else 4

                for new_node in new_nodes:
                    daily_assignments[next_best_day] = daily_assignments[next_best_day].append(
                        new_node, ignore_index=True, sort=False)

            elif df['totalProcccesPerMonth'].values[0] == 1:
                for new_node in new_nodes:
                    daily_assignments[best_day] = daily_assignments[best_day].append(
                        new_node, ignore_index=True, sort=False)
        elif workday == 6:
            if df['totalProcccesPerMonth'].values[0] == 3:
                first_group = (0, 2, 4)
                second_group = (1, 3, 5)

                best_group = get_best_group([first_group, second_group])

                for new_node in new_nodes:
                    for day in best_group:
                        daily_assignments[day] = daily_assignments[day].append(
                            new_node, ignore_index=True, sort=False)

            elif df['totalProcccesPerMonth'].values[0] == 2:
                if best_day <= 3:
                    first_day = best_day
                else:
                    first_day = 2

                for new_node in new_nodes:
                    daily_assignments[first_day] = daily_assignments[first_day].append(
                        new_node, ignore_index=True, sort=False)

                next_best_day = get_best_day(
                    range(first_day + 2, workday))

                for new_node in new_nodes:
                    daily_assignments[next_best_day] = daily_assignments[next_best_day].append(
                        new_node, ignore_index=True, sort=False)

            elif df['totalProcccesPerMonth'].values[0] == 1:
                for new_node in new_nodes:
                    daily_assignments[best_day] = daily_assignments[best_day].append(
                        new_node, ignore_index=True, sort=False)

    return daily_assignments


def read_excel(pools):
    data = pd.read_excel(r'../atm.xlsx')

    atms = pd.DataFrame(
        data, columns=['atmNo', 'coordinateY', 'coordinateX', 'totalProcccesPerMonth', 'Kayıtlı Olduğu Havuz'])

    frames = []
    for pool in pools:
        frames.append(atms.loc[atms['Kayıtlı Olduğu Havuz'] == pool])

    return pd.concat(frames).reset_index(drop=True)


def create_clusters(workday, pools, eps=0.5):
    data = connect_to_database(pools)[0]

    mainMatrix = pd.DataFrame(data)

    for i in mainMatrix.index:
        mainMatrix.at[i, 'totalProcccesPerMonth'] = ceil(mainMatrix.at[i,
                                                                       'totalProcccesPerMonth'] / 4)

    split_by_freqs = []
    for i in range(1, mainMatrix["totalProcccesPerMonth"].max() + 1):
        split_by_freqs.append(
            mainMatrix.loc[mainMatrix['totalProcccesPerMonth'] == i])

    freq_clusters = []
    for freq in split_by_freqs:
        freq_clusters.append(merge(freq, eps))

    daily_assignments = {}
    for day in range(workday):
        daily_assignments[day] = pd.DataFrame(
            columns=['atmNo', 'coordinateY', 'coordinateX'])

    for freq_cluster in freq_clusters:
        daily_assignments = appoint_to_days(
            freq_cluster, workday, daily_assignments)

    return daily_assignments


def create_distance_matrix(coordinates):
    depot = pd.DataFrame([[
        39.97275618603982, 32.84218942469761]], columns=["coordinateX", "coordinateY"])
    coordinates = pd.concat([depot, coordinates])

    distance_frame = pd.DataFrame(
        cdist(coordinates, coordinates, metric=haversine.haversine, unit=haversine.Unit.KILOMETERS))

    matrix = []
    for i in distance_frame:
        matrix.append([element for element in distance_frame[i].tolist()])

    return matrix


if __name__ == "__main__":

    daily_assignments = create_clusters(6, ["ANKARA-2"])

    print([len(daily_assignments[d].index) for d in daily_assignments])
