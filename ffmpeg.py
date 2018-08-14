# -*- coding: utf-8 -*-
from subprocess import call, check_output
import re
import os
import json

class Ffmpeg():
    
    def __init__(self):
        self.ffmpeg = '/bin/ffmpeg.exe'
        self.ffprobe = '/bin/ffprobe.exe'
        self.wdir = os.getcwd()
        self.sav_dir = os.environ['USERPROFILE'].replace("\\", "/") + \
        "/.musicapp" + "/_temp"
        
        if not os.path.exists(self.sav_dir):
            os.mkdir(self.sav_dir)
        
        os.chdir("C:/Users/GODWIN/Documents/GitHub/python-music-player/" +'bin/')
        #i = 'C:\\Users\\GODWIN\\Music\\Joyce-Blessing-–-I-Swerve-You-Prod.-By-Linkin-www.Ghanasongs.com_.mp3'
        #self.probe(i)
        #self.convert(i, 'mp3')


    def probe(self, i):
        info = {}
        out_print = check_output([
                'ffprobe', '-i',
                i,
                '-show_format',
                '-print_format',
                'json',
                '-v',
                'error'
                ], shell=True)
        raw = json.loads(out_print)
        data = raw['format']
        info['file'] = data['filename']
        info['format_name'] = data['format_name']
        info['size'] = data['size']
        
        # calc the seconds
        dura = float(data['duration'])
        mins = int(dura / 60)
        secs = int(dura - (mins * 60))
        if secs < 10:
            secs = '0' + str(secs)
        else:
            secs = str(secs)

        if (mins) > 59.9:
            hrs = int(dura / 3600)
            calc_time = str(hrs) + ":" + str(mins) + ":" + secs
        else:
            calc_time = str(mins) + ":" + secs
            
        print(calc_time)

        # use the calc time as duration
        info['duration'] = calc_time

        if 'tags' in data and 'title' in data['tags']:
            info.update(data['tags'])
        else:
            splits = os.path.split(i)
            name = splits[1]

            fake = {}
            fake['tags'] = {'title': name, 'artist': 'Unknown',
                'album': 'Unknown Album'}
            info.update(fake['tags'])

        return info
        
    
    def convert(self, input_file, format_name):


        i = input_file.replace("\\", "/")
        splits = os.path.split(i)
        file = splits[1]
        file = file.replace('.' + format_name, '')
        file = file + '.wav'
        o = self.sav_dir + "/" + file

        if not os.path.exists(o):
            check_output([
                'ffmpeg', '-i',
                i,
                o
                ], shell=True)

        return 0
    


#love = Ffmpeg()