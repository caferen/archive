import pymongo


def connect_to_database(pools, username="prod-r", password="prod-r", host_ip="192.168.101.248", port=27017, database="atm", atm_collection="atms", pool_collection="pools"):
    uri = f'mongodb://{username}:{password}@{host_ip}:{port}/{database}'

    client = pymongo.MongoClient(uri)
    db = client[database]

    atm_collection = db[atm_collection]
    atm_details = []

    pool_collection = db[pool_collection]
    pool_details = []

    for pool in pools:
        atm_query = {"projectId": 50, "state": True, "poolCode": pool}
        atm_data = atm_collection.find(
            atm_query, ['atmNo', 'coordinateX', 'coordinateY', 'totalProcccesPerMonth'])
        atm_details += list(atm_data)

        pool_query = {"poolCode": pool}
        pool_data = pool_collection.find(pool_query, ["users"])
        pool_details += list(pool_data)

    return [atm_details, pool_details]


if __name__ == "__main__":
    print(connect_to_database(['ANKARA-11'])[1])
