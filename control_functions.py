import sys
import threading
import pyaudio
import wave
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

class Control(QObject):


    """
    """

    def __init__(self):


        """
        """


        QObject.__init__(self)
        self.file = ''
        self.app_running = True
        self._not_paused = True
        

    @pyqtSlot(str)
    def play(self, file):


        """
        """


        self.file = file
        play_thread = threading.Thread(target=self._play)
        play_thread.start()


    def _play(self):


        """
        """


        print(self.file)
        self.file = "C:/Windows/media/Alarm04.wav"
        
        mbin = wave.open(self.file, mode='rb')
        
        pyaud = pyaudio.PyAudio()
        
        srate=44100
        stream = pyaud.open(format = pyaud.get_format_from_width(2),
                        channels = 1,
                        rate = srate,
                        output = True)

        data = mbin.readframes(1024)
        
        while data:

            while self.app_running:
                stream.write(data)
                data = mbin.readframes(8192)

        mbin.close()
        stream.stop_stream()
        stream.close()

        pyaud.terminate()
