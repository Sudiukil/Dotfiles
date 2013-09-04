import os

moduleName = "py3status public IP module 0.2"

class Py3status:
	def mainMethod(self, json, i3status_config):
		os.system("sleep 10")
		if os.system("curl -s 192.168.1.1 | grep 'Livebox' > /dev/null") == 0:
			pubIp = os.popen("curl -s 192.168.1.1 | grep '90.' | cut -d '>' -f 2 | cut -d '<' -f 1").readline()[:-1]
		else:
			pubIp = os.popen("curl -s ifconfig.me/ip").readline()[:-1]
		display = "IP Publique: " + pubIp
		return (1, {"full_text" : display, "name" : moduleName})
