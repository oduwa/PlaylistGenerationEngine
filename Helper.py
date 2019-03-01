from skimage.color import rgb2gray
import numpy as np
from scipy import misc
import matplotlib.pyplot as plt
import os, sys, shutil
import string
import random
import pickle
import scipy.io.wavfile as wav
import python_speech_features as psf
import mutagen
from pydub import AudioSegment
AudioSegment.converter = "/usr/local/bin/ffmpeg"
import re
import shutil

ID3V2_ARTWORK_TAG = "APIC:Cover"
ARTWORK_DIRECTORY_PATH = os.path.dirname(__file__) + "/Artworks"

def save_image_from_song(songpath, imagepath, save_default_cover=False):
    if(not save_default_cover):
        f = mutagen.File(songpath) # mutagen can automatically detect format and type of tags
        print "KEYS IN MUSIC TAG: {}".format(f.keys())
        if(ID3V2_ARTWORK_TAG in f):
            artwork = f[ID3V2_ARTWORK_TAG].data # access APIC frame and grab the image
            with open(imagepath, 'wb') as img:
                img.write(artwork) # write artwork to new image
    else:
        shutil.copyfile(ARTWORK_DIRECTORY_PATH+"/default.jpg", imagepath)

def mp3_folder_to_wav(dirname):
    for filename in os.listdir(dirname):
        if(".mp3" in filename):
            sound = AudioSegment.from_mp3(dirname + "/" + filename)
            sound.export(dirname + "/" + filename.split(".")[0] + ".wav", format="wav")
            os.remove(dirname + "/" + filename)

def mp3_file_to_wav(filepath):
    sound = AudioSegment.from_mp3(filepath)
    sound.export(filepath[:-4] + ".wav", format="wav")
    return filepath[:-4] + ".wav"

def wav_to_mfcc(wav_path, TRUNC=5000):
    fs, X = wav.read(wav_path)
    mfcc_features = psf.mfcc(X, samplerate=fs).flatten()[:TRUNC]
    return (mfcc_features,fs)

def generate_random_id(length=8):
    identifier = ""
    for i in xrange(length):
        identifier = identifier + random.choice(string.ascii_letters + string.digits)
    return identifier


def block_proc(A, blockSize, blockFunc):
    xStart = 0;
    xStop = A.shape[1]
    if(xStop % blockSize[0] != 0):
        xStop = int(xStop/blockSize[0]) * blockSize[0]

    yStart = 0;
    yStop = A.shape[0]
    if(yStop % blockSize[1] != 0):
        yStop = int(yStop/blockSize[1]) * blockSize[1]

    print("xStop: {} | yStop: {}".format(xStop, yStop))

    for x in xrange(xStart, xStop, blockSize[0]):
        for y in xrange(yStart, yStop, blockSize[1]):
            block = A[y:y+blockSize[1], x:x+blockSize[0]]
            blockFunc(block)

def serialize(filename, obj):
    f = open(filename, 'w+b')
    pickle.dump(obj, f)
    f.close()

def unserialize(filename):
    try:
        f = open(filename, 'rb')
        obj = pickle.load(f)
        f.close()
        return obj
    except:
        return None

def quoteForPOSIX(string):
    '''quote a string so it can be used as an argument in a  posix shell

       According to: http://www.unix.org/single_unix_specification/
          2.2.1 Escape Character (Backslash)

          A backslash that is not quoted shall preserve the literal value
          of the following character, with the exception of a <newline>.

          2.2.2 Single-Quotes

          Enclosing characters in single-quotes ( '' ) shall preserve
          the literal value of each character within the single-quotes.
          A single-quote cannot occur within single-quotes.

    '''

    string = str.replace(string, " ", "\ ")
    return "\\'".join("'" + p + "'" for p in string.split("'"))



# x = np.zeros((156,160))
# blockFunc = lambda block: Display.show_image(block, isGray=True)
# y = rgb2gray(misc.imread("Misc/whiteboard.png"))
# block_proc(y, blockSize=32, blockFunc=blockFunc)
