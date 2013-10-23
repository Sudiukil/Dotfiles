#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {

	char buffer[256];

	char *getDate() {
		FILE *dateStdout = popen("date \"+%d/%m/%Y - %H:%M:%S\"", "r");
		char *date = fgets(buffer, sizeof(buffer), dateStdout);
		pclose(dateStdout);
		date[strlen(date)-1] = '\0';
		return date;
	}

	char *getVolume() {
		FILE *amixerStdout = popen("amixer -c 0 get Master | grep '%' | cut -d '[' -f 2 | sed 's/] //g'", "r");
		char *volume = fgets(buffer, sizeof(buffer), amixerStdout);
		pclose(amixerStdout);
		volume[strlen(volume)-1] = '\0';
		return volume;
	}

	char *getDiskUsage(char *disk) {
		char command[106] = "disk=";
		strcat(command, disk);
		strcat(command, " && df -h --output=source,pcent | grep $disk | sed 's/ //g' | sed 's/'\"$disk\"'/'\"$disk: \"'/'");
		FILE *dfStdout = popen(command, "r");
		char *usage = fgets(buffer, sizeof(buffer), dfStdout);
		pclose(dfStdout);
		usage[strlen(usage)-1] = '\0';
		return usage;
	}

	char *getPublicIp() {
		FILE *curlStdout = popen("curl -s 192.168.1.1 | grep \"90.\" | cut -d '>' -f 2 | cut -d '<' -f 1", "r");
		char *publicIp = fgets(buffer, sizeof(buffer), curlStdout);
		pclose(curlStdout);
		publicIp[strlen(publicIp)-1] = '\0';
		return publicIp;
	}

	char *getMocInfos(char *request) {
		char command[14] = "mocp -Q \%";
		strcat(command, request);
		FILE *mocpStdout = popen(command, "r");
		char *info = fgets(buffer, sizeof(buffer), mocpStdout);
		pclose(mocpStdout);
		info[strlen(info)-1] = '\0';
		return info;
	}

	void display(char *data, int priority, int last) {
		char jsonStr[128] = "{\"full_text\":\"";
		strcat(jsonStr, data);
		switch(priority) {
			case 0:
				strcat(jsonStr, "\"}");
				break;
			case 1:
				strcat(jsonStr, "\",\"color\":\"#ffff00\"}");
				break;
			case 2:
				strcat(jsonStr, "\",\"color\":\"#ff0000\"}");
				break;
		}
		if(last==0) {
			strcat(jsonStr, ",");
		}
		printf("%s", jsonStr);
	}

	puts("[");
	display(getPublicIp(), 0, 0);
	display(getDiskUsage("sda6"), 0, 0);
	display(getDiskUsage("sda7"), 0, 0);
	display(getDiskUsage("sda8"), 0, 0);
	display(getDiskUsage("sda9"), 0, 0);
	display(getDiskUsage("sda10"), 0, 0);
	display(getDate(), 0, 0);
	display(getVolume(), 0, 1);
	puts("],");

	return 0;
}
