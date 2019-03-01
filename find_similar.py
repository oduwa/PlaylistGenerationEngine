import MusicKnn
import Helper
import os
import sys
import json


DB_FILESTORE = os.path.dirname(__file__) + "/MusicCollection/Database.mdb"

# Load input
projectdir = str.replace(os.path.abspath(os.path.join(sys.argv[1], os.pardir)), "uploads", "")
path = projectdir + sys.argv[1]
wav_path = Helper.mp3_file_to_wav(path)

# Compute nearesst neighbours
MusicKnn.TRUNC = 200000
mfcc = MusicKnn.wav_to_mfcc(wav_path)
nn = MusicKnn.find_nearest_neighbour(mfcc)

# Construct JSON response
db_map = Helper.unserialize(DB_FILESTORE)
results = []
for neighbour in nn:
    result = db_map[neighbour]
    result.pop("features", None)
    results.append(result)
json_response = json.dumps(results)

print(json_response)
