# -*- coding: utf-8 -*-
import os
import threading

class Fs():
    
    
    def __init__(self):
        self.files = []
        self._prep_file = ""
        self._prep_folder = ""



    def prepare(self, file):
        
        # start thred
        #_prepare()
        # call _prepare
        self._prep_file = file
        prep_thread = threading.Thread( target = self._prepare )
        prep_thread.start()
        
    def _prepare(self):
    
        # do the job
        splits = os.path.split(self._prep_file)
        self._prep_folder = splits[0]
        print(self._prep_file)
