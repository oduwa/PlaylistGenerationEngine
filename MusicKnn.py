import python_speech_features as psf
import scipy.io.wavfile as wav
from pydub import AudioSegment
import os, sys, shutil
import numpy as np
from sklearn import svm, metrics
from sklearn.neighbors import NearestNeighbors
import Helper
import os, sys, shutil
import wavio
import wave

DB_FILESTORE = os.path.dirname(__file__) + "/MusicCollection/Database.mdb"
TRUNC = 200000

def get_knn(ser=os.path.dirname(__file__) + "/Models/knn.data"):
    knn = Helper.unserialize(ser)

    if(knn == None):
      knn = build_knn()
      Helper.serialize(ser, knn)

    return knn


def build_knn(traindir=os.path.dirname(__file__) + "/MusicCollection"):
    #Helper.mp3_folder_to_wav(traindir)
    # train_filenames = []
    # for filename in os.listdir(traindir):
    #     if(".wav" in filename):
    #         train_filenames.append(traindir + "/" + filename)


    # Load database file
    f = open(DB_FILESTORE, 'rb')
    f.close()
    db_map = Helper.unserialize(DB_FILESTORE)

    train_data = np.zeros((len(db_map), TRUNC))
    i = 0
    for song_title in db_map.keys():
        try:
            song = db_map[song_title]
            mfcc_features = song['features']
            # Truncate mfcc features to ensure all uniform
            flattened_mfcc = mfcc_features.flatten()[:TRUNC]

            # First check that feature vector was long enough to truncate.
            # If not, pad the end
            if(flattened_mfcc.shape[0] < TRUNC):
                difference = TRUNC - flattened_mfcc.shape[0]
                flattened_mfcc = np.lib.pad(flattened_mfcc, (0,difference), 'mean')
            train_data[i] = flattened_mfcc
        except wave.Error as err:
            print("ERROR: {}".format(err))
            print("FAILED TO READ WAV FILE: {}".format(train_filename))
        i = i+1

    nbrs = NearestNeighbors(n_neighbors=7, algorithm='ball_tree').fit(train_data)
    #nbrs = NearestNeighbors(n_neighbors=3, algorithm='brute', metric='cosine').fit(train_data)
    return nbrs

def wav_to_mfcc(wav_path):
    fs, X = wav.read(wav_path)
    mfcc_features = psf.mfcc(X, samplerate=fs).flatten()[:TRUNC]
    if(mfcc_features.shape[0] < TRUNC):
        difference = TRUNC - mfcc_features.shape[0]
        mfcc_features = np.lib.pad(mfcc_features, (0,difference), 'mean')
    return mfcc_features

def targets(traindir=os.path.dirname(__file__)+"/MusicCollection"):
    '''
    Returns a list of targets in the same order as the training order for the knn.
    '''
    db_map = Helper.unserialize(DB_FILESTORE)
    return db_map.keys()

def find_nearest_neighbour(mfcc_features):
    '''
    Returns a list of the names of the nearest neighbours
    '''
    knn = get_knn()
    distances, indices = knn.kneighbors(mfcc_features)
    #print((distances, indices))

    # Return 2nd closest because 1st closest might be the same song with a different filename
    nearest_neighbours = []
    for nearest_indices in indices[0]:
        nearest_neighbours.append(targets()[nearest_indices])

    return nearest_neighbours


if __name__ == "__main__":
    knn = Helper.unserialize("Models/knn.data")

    if(knn == None):
      mp3_to_wav("ScrapedSongs")
      knn = train_knn()
      Helper.serialize("knn.data", knn)

    fs, X = wav.read("ScrapedSongs/-Chance The Rapper- - Chance The Rapper and The Social Experiment - Wonderful Everyday- Arthur.wav")
    mfcc_features = psf.mfcc(X, samplerate=fs).flatten()[:5000]
    distances, indices = knn.kneighbors(mfcc_features)
    print(indices)
    train_filenames = []
    traindir = "ScrapedSongs"
    for filename in os.listdir("ScrapedSongs"):
      if(".wav" in filename):
          train_filenames.append(traindir + "/" + filename)
    print(train_filenames[indices[0][1]])
