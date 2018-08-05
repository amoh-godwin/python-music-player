"""
    Thank you King Eternal
"""

import sys

from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import QQmlApplicationEngine

from PyQt5.QtCore import QObject

from control_functions import Control

from fs import Fs

from test import Person

class MusicApp():


    def __init__(self):
        super.__init__
        self.HOME_PATH = ""
        self.main_qml = ""
        self.control = ()

        self._preprocesses()


    def _postprocesses(self):
    
    
        """
        """
    

        self.control.app_running = False
    
    
    def _preprocesses(self):
    
    
        """
        """
    
        self.HOME_PATH = sys.argv[0].replace('music.py', '')
    
        self.main_qml = self.HOME_PATH + "/" + "ui/main.qml"
        
        # check if user supplied music file
        if len(sys.argv) > 1:
            fs = Fs()
            fs.prepare(sys.argv[1])
        
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
        engine.load(self.main_qml)
        engine.quit.connect(app.quit)
        app.aboutToQuit.connect(self._postprocesses)
        sys.exit(app.exec_())


# Run the main thing
MusicApp()
