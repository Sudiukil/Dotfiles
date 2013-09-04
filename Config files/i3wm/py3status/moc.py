import os

moduleName = "py3status MOC module 0.3"

class Py3status:
	def mainMethod(self, json, i3status_config):
		state = os.popen("mocp -Q %state").readline()[:-1]
		if state == "PLAY":
			title = os.popen("mocp -Q %title").readline()[:-1]
			currentTime = os.popen("mocp -Q %ct").readline()[:-1]
			timeLeft = os.popen("mocp -Q %tl").readline()[:-1]
			totalTime = os.popen("mocp -Q %tt").readline()[:-1]
			display = "MOC: " + state + ': ' + title + ' ' + currentTime + '/' + timeLeft + ' [' + totalTime + ']'
		else:
			display = "MOC: " + state
		return (0, {"full_text" : display, "name" : moduleName})
