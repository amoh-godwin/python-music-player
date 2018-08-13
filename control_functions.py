import os
import sys
import threading
import wave
import pyaudio
from ffmpeg import Ffmpeg
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
        self._not_stopped = False
        self.ff = Ffmpeg()
        
    stillPlaying = pyqtSignal(str, arguments=['playing'])
    completedPlaying = pyqtSignal(str, arguments=["complete"])
        

    @pyqtSlot(str, str)
    def play(self, file, f_for):


        """
        """


        self._not_stopped = False
        self.file = file
        play_thread = threading.Thread(target=self._play, args=[f_for])
        play_thread.start()


    def _play(self, f_for):


        """
        """

        splits = os.path.split(self.file)
        filename = splits[1].replace(f_for, 'wav')
        file = self.ff.sav_dir + '/' + filename
        if self.app_running:
            self.ff.convert(self.file, f_for)
        else:
            return 1
        print('quick or ')

        pyaud = pyaudio.PyAudio()

        wf = wave.open(file, mode='rb')
        
        stream = pyaud.open(format=pyaud.get_format_from_width(wf.getsampwidth()),
                channels=wf.getnchannels(),
                rate=wf.getframerate(),
                output=True)

        self.playing()
        self._not_stopped = True
        
        data = wf.readframes(1)

        while self.app_running and len(data) != 0:


            if self._not_stopped:
                if self._not_paused:
    
                    stream.write(data)
                    data = wf.readframes(512)

                else:
                    
                    #pause
                    pass
            else:
                break

        wf.close()
        stream.stop_stream()
        stream.close()

        pyaud.terminate()
        self.complete()


    @pyqtSlot()
    def pause(self):


        """
        """


        pause_thread = threading.Thread(target=self._pause)
        pause_thread.start()


    def _pause(self):


        """
        """

        self._not_paused = False


    @pyqtSlot()
    def resume(self):


        """
        """


        resume_thread = threading.Thread(target=self._resume)
        resume_thread.start()


    def _resume(self):


        """
        """

        self._not_paused = True


    def playing(self):


        """
        """


        self.stillPlaying.emit('playing')


    def complete(self):


        """
        """


        print('complete')
        if self._not_paused:
            self.completedPlaying.emit('')
        elif self._not_stopped:
            pass
        else:
            self.completedPlaying.emit('')
