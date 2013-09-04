import os

moduleName = "py3status public IP module 0.1"

class Py3status:
	def mainMethod(self, json, i3status_config):
		pubIp = os.popen("sleep 300 && curl ifconfig.me").readline()[:-1]
		display = "IP Publique: " + pubIp
		return (1, {"full_text" : display, "name" : moduleName})
