# -*- coding: utf-8 -*-
import os
from time import sleep
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
        self.filesPrevCount = 0
        self.now_crawling = True
        self.prop = 0
        self.has_booted = False
        self._sub_files = []
        self._prep_file = ""
        self.prep_file_index = 0
        self._prep_folder = ""
        self._supported_ext = ('.mp3', '.aac', '.wav', '.m4a', '.ogg')

    startUp = pyqtSignal(list, arguments=['bootUp'])
    called = pyqtSignal(list, arguments=['callToPlay'])
    propertyChanged = pyqtSignal(list, arguments=['propertyNotifier'])

    @pyqtSlot()
    def bootUp(self):

        # send the files
        self.propertyNotify(self.files)
        self.startUp.emit(self.files)


    def propertyNotify(self, prop):
        
        
        self.prop = prop
        
        propNoti = threading.Thread(target = self._propertyNotify)
        propNoti.start()

    def propertyNotifier(self, result):
        
        print(result[0])
        self.propertyChanged.emit(result)


    def _propertyNotify(self):
        
        while self.app_running:
            
            sleep(.5)
            if self.now_crawling:
                
                count = len(self.prop)
                if count > self.filesPrevCount:
                    self.filesPrevCount = count
                    self.propertyNotifier([count, self.prop])


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
        
        self.callToPlay()


    def callToPlay(self):
        
        print('\n\n\nhas been called ')
        index = self.prep_file_index
        lists = [self._prep_file, self.files[index]['format_name'], index ]

        self.called.emit(lists)

    
    def subs_prep(self, folder):

        # _subs_preb()
        sub_preb = threading.Thread( target = self._subs_preb )
        sub_preb.start()
    

    def _subs_preb(self):

        # check if folder has been scanned before
        if self._prep_folder not in self.folders:
            self.now_crawling = True
            self.folders.add(self._prep_folder)
        else:
            self.now_crawling = False
            return

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
                
            
            self.prep_file_index = self.files.index(info)

    def _list_dir(self, directory):

        print('\n\n\n here \n\n\n')
        sleep(15)
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
