# -*- coding: utf-8 -*-
import os
import threading
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from ffmpeg import Ffmpeg
from folder_list import Folders
import files_list

class Fs(QObject):
    
    
    def __init__(self):
        QObject.__init__(self)
        self.app_running = True
        self.ff = Ffmpeg()
        self.folders = set(Folders)
        self.files = files_list.Files
        self._sub_files = []
        self._prep_file = ""
        self._prep_folder = ""
        self._supported_ext = ('.mp3', '.aac', '.wav', '.m4a', '.ogg')

    startUp = pyqtSignal(list, arguments=['bootUp'])

    @pyqtSlot()
    def bootUp(self):

        # send the files
        self.startUp.emit(self.files)


    def prepare(self, file):
        
        # start thred
        #_prepare()
        # call _prepare
        self._prep_file = file.replace("\\", "/")
        prep_thread = threading.Thread( target = self._prepare )
        prep_thread.start()


    def _prepare(self):
    
        # do the job
        splits = os.path.split(self._prep_file)
        self._prep_folder = splits[0] 
        
        self.subs_prep(self._prep_folder)
        
        self._ffjob(self._prep_file)

    
    def subs_prep(self, folder):
        
        # _subs_preb()
        sub_preb = threading.Thread( target = self._subs_preb )
        sub_preb.start()
    

    def _subs_preb(self):

        # check if folder has been scanned before
        if self._prep_folder not in self.folders:
            print('now crawling:', self._prep_folder)
            self.folders.add(self._prep_folder)
        else:
            print('checking old files')

        files = self._list_dir(self._prep_folder)
        files.remove(self._prep_file)
        for a in files:
            tags = self.ff.probe(a)
            
            if tags not in self.files:
                self.files.append(tags)


    def ffjob(self, file):
        print('\n\n\ncalled\n\n\n')
        self._ffjob(file)


    def _ffjob(self, file):
        
        if self.app_running:
            
            # check if app is running
            if not self.app_running:
                return False
            info = self.ff.probe(file)
            
            # check if app is running
            if not self.app_running:
                return False
            self.ff.convert(file, info['format_name'])

            # check if app is running
            if not self.app_running:
                return False
            
            if info not in self.files:
                self.files.append(info)

    def _list_dir(self, directory):

        self._search(directory)
        return self._sub_files


    def _is_dir(self, entry):

        try:
            os.listdir(entry)
            self._search(entry)
            return True
        except:
            return False

    def _search(self, directory):
        
        list_dir = os.listdir(directory)
        for entry in list_dir:
            path = directory + "/" + entry
            if self._is_dir(path):
                pass
            else:
                split = os.path.splitext(entry)
                if split[1] in self._supported_ext:
                    self._sub_files.append(path)
