# -*- coding: utf-8 -*-
from subprocess import call
import os

class Ffmpeg():
    
    def __init__(self):
        self.ffmpeg = '/bin/ffmpeg.exe'
        os.chdir('bin/')
        self._get()
        
        
    
    def _get(self, i, o):

        cmd = 'ffmpeg -i C:/Users/GODWIN/Music/Ebezina.mp3 C:/Users/GODWIN/Music/Ebezina.wav'
        call(cmd, shell=True)
        print('love')
    


Ffmpeg()