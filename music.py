"""
    Thank you King Eternal
"""

import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from PyQt5.QtCore import QObject

from control_functions import Control

class MusicApp():


    def __init__(self):
        super.__init__
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
    
        self.main_qml = "ui/main.qml"
        self._startUp()
    
    
    def _startUp(self):
    
    
        """
        """
    
    
        # start app
        app = QGuiApplication(sys.argv)
        engine = QQmlApplicationEngine()
        self.control = Control()
        engine.rootContext().setContextProperty('Functions', self.control)
        engine.load(self.main_qml)
        engine.quit.connect(self._postprocesses)
        sys.exit(app.exec_())


# Run the main thing
MusicApp()
