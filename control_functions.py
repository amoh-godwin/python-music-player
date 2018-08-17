import os
from time import sleep
import threading
import wave
import numpy as np
import struct
import pyaudio
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

from ffmpeg import Ffmpeg

class Control(QObject):


    """
    """


    def __init__(self):


        """
        """


        QObject.__init__(self)
        self.file = ''
        self.file_size = 0
        self.app_running = True
        self._not_paused = True
        self._not_stopped = False
        self.t_size = 0
        self.tt_played = 0
        self.volume_val = 1.4
        self.ff = Ffmpeg()
        print(threading.enumerate())
        
    stillPlaying = pyqtSignal(str, arguments=['playing'])
    completedPlaying = pyqtSignal(str, arguments=["complete"])
    

    @pyqtSlot(str, str, str)
    def play(self, file, f_for, size):


        """
        """


        self._not_stopped = False
        sleep(2)
        self.file = file
        self.file_size = int(size)
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
        self._not_paused = True

        a = wf.readframes(1)

        print('\n\n inside here \n', self._not_paused, self._not_stopped )

        while self.app_running and len(a) != 0:


            if self._not_stopped:
                if self._not_paused:
    
                    stream.write(a)
                    #a = wf.readframes(512)
                    
                    a = (np.fromstring(wf.readframes(512), np.int16) )
                    self.t_played()
                    b = []
                    for x in a:
                        var = int(float(x) / self.volume_val)
                        b.append(var)
                    a = b
                    a = struct.pack('h'*len(a), *a)

                else:
                    
                    #pause
                    sleep(.1)
            else:
                break

        wf.close()
        stream.stop_stream()
        stream.close()

        pyaud.terminate()
        self.complete()


    @pyqtSlot()
    def stop(self):
        
        """
        """
        
        
        stop_thread = threading.Thread(target=self._stop)
        stop_thread.start()
        # implement a wait
        sleep(1)


    def _stop(self):
        
        
        """
        """
        
        
        self._not_stopped = False
        return


    @pyqtSlot()
    def pause(self):


        """
        """


        pause_thread = threading.Thread(target=self._pause)
        pause_thread.start()
        sleep(1)


    def _pause(self):


        """
        """

        self._not_paused = False
        return


    @pyqtSlot()
    def resume(self):


        """
        """


        resume_thread = threading.Thread(target=self._resume)
        resume_thread.start()
        sleep(1)


    def _resume(self):


        """
        """

        self._not_paused = True
        return


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
            

    @pyqtSlot(str)
    def controlVolume(self, deci):


        """
        """


        cont = threading.Thread( target=self._controlVolume, args=[deci] )
        cont.start()


    def _controlVolume(self, deci):


        """
        """


        vol = float(deci)
        vol = format(100 / vol, '.1f')
        r_vol = float(vol)
        self.volume_val = r_vol


    def t_played(self):


        """
        """
        
        
        t_play = threading.Thread( target = self._t_played )
        t_play.start()


    def _t_played(self):


        """
        """


        self.tt_played += 512
        per = self.tt_played / self.file_size * 100
        print(per)
        print(self.file_size)
        print(self.tt_played)
        return


    def propertyNotify(self, prop):


        self.prop = prop
        
        propNoti = threading.Thread(target = self._propertyNotify)
        propNoti.start()

    def propertyNotifier(self, result):
        

        self.propertyChanged.emit(result)


    def _propertyNotify(self):
        
        while self.app_running and self._not_stopped:
            
            sleep(.3)
                
            count = self.prop
            if count > self.filesPrevCount:
                self.filesPrevCount = count
                self.propertyNotifier([count, self.prop])


    def endPropertyChange(self):
        
        sleep(1)
        count = len(self.prop)
        result = [count, '']

        # emit the end of property
        self.endOfPropertyChange.emit(result)


    def endProperty(self):
        
        self.now_crawling = False

        self.endPropertyChange()

        endProp = threading.Thread( target = self._endProperty )
        endProp.start()


    def _endProperty(self):
        
        sleep(15)
        self.prop = 0
        self.propertyEnded()


    def propertyEnded(self):
 
        result = []
        self.propertyEnd.emit(result)
