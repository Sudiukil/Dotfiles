import os

moduleName = "Py3status MOC module 0.2"

class Py3status:
	def mainMethod(self, json, i3status_config):
		state = os.popen("mocp -Q %state").readline()[:-1]
		if state == "PLAY":
			display = "MOC: " + state + ": " + os.popen("mocp -Q %title").readline()[:-1]
		else:
			display = "MOC: " + state
		return (0, {"full_text" : display, "name" : moduleName})
