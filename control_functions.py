import sys
import pyaudio
import wave
from urllib.request import urlopen
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

class Control(QObject):


    """
    """

    def __init__(self):



        """
        """


        QObject.__init__(self)
        

    @pyqtSlot(str)
    def play(self, file):


        """
        """


        # pyaudio lets go
        file = "C:/Windows/media/Alarm04.wav"
        print(file)
        
        mbin = wave.open(file, mode='rb')
        
        pyaud = pyaudio.PyAudio()
        
        srate=44100
        stream = pyaud.open(format = pyaud.get_format_from_width(2),
                        channels = 1,
                        rate = srate,
                        output = True)
        
        
        #url = "file:///" + file # Assuming you retrive audio data from an URL
        #mbin = urlopen(url)
        data = mbin.readframes(1024)
        
        while data:
            stream.write(data)
            data = mbin.readframes(8192)

        mbin.close()
        stream.stop_stream()
        stream.close()

        pyaud.terminate()
