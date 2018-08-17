"""
    Thank you King Eternal
"""

import sys
import os
from time import sleep
from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import QQmlApplicationEngine



from control_functions import Control

from fs import Fs

class MusicApp():


    def __init__(self):
        super.__init__
        self.HOME_PATH = ""
        self.main_qml = ""
        self.control = ()
        self.fileSys = Fs()

        self._preprocesses()

    def _postprocesses(self):


        """
        """
    

        self.control.app_running = False
        self.fileSys.app_running = False
        self.rebuildFiles()
        self.cleanUpFiles()


    def rebuildFiles(self):
        
        # folder list
        with open(self.HOME_PATH + "/" + 'folder_list.py', 'wb') as f_hand:
            data_f = b"Folders = " + bytes(str(list(self.fileSys.folders)),
                                           'utf-8')
            f_hand.write(data_f)

        # files list
        with open(self.HOME_PATH + "/" + 'files_list.py', 'wb') as fi_hand:
            data_fi = b"Files = " + bytes(str(self.fileSys.files), 'utf-8')
            fi_hand.write(data_fi)
            
        return

    def cleanUpFiles(self):
        
        sleep(.3)
        folder = os.environ['USERPROFILE'].replace("\\", "/") + \
        "/.musicapp" + "/_temp"
        tmp_files = os.listdir(folder)
        for a in tmp_files:
            file = folder + "/" + a
            print('Removing:', file)
            os.remove(file)


    def _preprocesses(self):
    
    
        """
        """
    
        self.HOME_PATH = sys.argv[0].replace('music.py', '').replace("\\", "/")
    
        self.main_qml = self.HOME_PATH + "/" + "ui/main.qml"
        
        # check if user supplied music file
        if len(sys.argv) > 1:
            self.fileSys.prepare(sys.argv[1])
        
        self._startUp()

    
    def _startUp(self):
    
    
        """
        """
    
    
        # start app
        app = QGuiApplication(sys.argv)
        app.setWindowIcon(QIcon(self.HOME_PATH + 'ui/images/ic_album_black_24dp.png'))
        engine = QQmlApplicationEngine()
        self.control = Control()
        engine.rootContext().setContextProperty('Functions', self.control)
        engine.rootContext().setContextProperty('FileSys', self.fileSys)
        engine.load(self.main_qml)
        engine.quit.connect(app.quit)
        app.aboutToQuit.connect(self._postprocesses)
        sys.exit(app.exec_())


# Run the main thing
MusicApp()
