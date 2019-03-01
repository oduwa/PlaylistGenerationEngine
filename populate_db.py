import subprocess
from urllib2 import urlopen
import requests
import re, os
import Helper

DB_FILESTORE = os.path.dirname(__file__) + "/MusicCollection/Database.mdb"

#subprocess.call(['python', 'soundscrape/soundscrape.py', 'https://soundcloud.com/msftsrepmusic/jaden-smith-fallen', '-p', 'ScrapedSongs'])
#subprocess.call(['python', 'soundscrape/soundscrape.py', 'oddysey', '-l', '-p', 'ScrapedSongs'])

categories = [
    "all-music",
    "alternativerock",
    "ambient",
    "classical",
    "country",
    "danceedm",
    "dancehall",
    "deephouse",
    "disco",
    "drumbass",
    "dubstep",
    "electronic",
    "folksingersongwriter",
    "hiphoprap",
    "house",
    "indie",
    "jazzblues",
    "latin",
    "metal",
    "piano",
    "pop",
    "rbsoul",
    "reggae",
    "reggaeton",
    "rock",
    "soundtrack",
    "techno",
    "trance",
    "trap",
    "triphop",
    "world"
]
categories = ['hiphoprap','rock']

# Entire list of songs is a hashmap where each key points to another dictionary
# which contains the songs data.
# This allows us to handle duplication as if theyre the same key (ie song name)
# it just overrides whatever was already saved there.
db_map = {}

for category in categories:
    print("SCRAPING SONGS IN CATEGORY - " + category)

    # Get url for charts category
    url = "https://soundcloud.com/charts/top?genre=" + category

    # Scrape charts page for song links
    html = urlopen(url).read()
    matches = re.findall('(itemprop=\"url\" href=)(\".*?\")', html, re.DOTALL)
    song_links = ["http://soundcloud.com" + match[1].replace("\"", "") for match in matches]

    # For each song
    for link in song_links:
        # Download song
        subprocess.call(['python', os.path.dirname(__file__)+'/soundscrape/soundscrape.py', link, '-p', os.path.dirname(__file__)+'/MusicCollection'])

        # Get filename of downloaded song
        mp3filepath = None
        wavfilepath = None
        name = None
        for filename in os.listdir(os.path.dirname(__file__) + '/MusicCollection'):
            if(".mp3" in filename and ".tmp" not in filename):
                mp3filepath = os.path.dirname(__file__) + '/MusicCollection/' + filename
                name = filename
                break
            if(".wav" in filename and ".tmp" not in filename):
                wavfilepath = os.path.dirname(__file__) + '/MusicCollection/' + filename
                name = filename
                break

        extracted_artwork = False
        artwork_filename = str.replace(str.replace(filename,".mp3",".jpg"), ".wav", ".jpg")
        artwork_filepath = os.path.dirname(__file__)+"/Artworks/"+artwork_filename

        # Convert to wav if necessary
        if(mp3filepath != None):
            # Save artwork
            Helper.save_image_from_song(mp3filepath, artwork_filepath)
            extracted_artwork = True
            # Convert to wav and delete mp3
            wavfilepath = Helper.mp3_file_to_wav(mp3filepath)
            os.remove(mp3filepath)

        # Extract mfcc features from wav and store
        if(wavfilepath != None):
            # extract features
            mfcc_features, fs = Helper.wav_to_mfcc(wavfilepath)
            db_entry = {"features":mfcc_features, "title":name[:-4], "url":link, "sample_frequency":fs} #TODO: Get more song metadata from m3 tags maybe
            db_map[name[:-4]] = db_entry
            os.remove(wavfilepath)

        if(not extracted_artwork):
            Helper.save_image_from_song(None, artwork_filepath, save_default_cover=True)

    Helper.serialize(DB_FILESTORE, db_map)

# serialize scraped data
Helper.serialize(DB_FILESTORE, db_map)


print("##########################################")
print('done.')
