import wavio
import scipy.io.wavfile as wav
import python_speech_features as psf
import Helper
from sklearn import metrics

trunc = 200000
fs1, X1 = wav.read("MusicCollection/" + "06 Shadows.wav")
fs2, X2 = wav.read("MusicCollection/" + "09 3005.wav")
fs2, X2 = wav.read("MusicCollection/" + "XXXTENTACION - xxxtentacion feat. $ki Mask -The Slump God- - R.I.P ROACH -EAST SIDE SOULJA- (Prod. Stain).wav")
feat1 = psf.mfcc(X1, samplerate=fs1).flatten()[:trunc]
feat2 = psf.mfcc(X2, samplerate=fs2).flatten()[:trunc]
sim = metrics.pairwise.cosine_similarity(feat1,feat2)
print(sim)
