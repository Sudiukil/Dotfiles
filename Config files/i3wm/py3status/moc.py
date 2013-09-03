import os

moduleName = "Py3status MOC module 0.1"

class Py3status:
	def mainMethod(self, json, i3status_config):
		state = os.popen("mocp -Q %state").readline()[:-1]
		if state == "PLAY":
			display = state + ": " + os.popen("mocp -Q %title").readline()[:-1]
			output = (0, {"full_text" : display, "name" : moduleName})
		else:
			output = (0, {"full_text" : state, "name" : moduleName})
		return output
