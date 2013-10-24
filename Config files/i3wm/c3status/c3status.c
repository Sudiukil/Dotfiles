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
		FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 2 | sed -e 's/ //g' -e 's/]//'", "r");
		char *volume = fgets(buffer, sizeof(buffer), amixerStdout);
		pclose(amixerStdout);
		volume[strlen(volume)-1] = '\0';
		return volume;
	}

	int testVolumeState() {
		FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 4 | sed -e 's/on]/1/' -e 's/off]/0/'", "r");
		char *state = fgets(buffer, sizeof(buffer), amixerStdout);
		pclose(amixerStdout);
		if((int)state[0]=='1') {
			return 0;
		}
		else {
			return 1;
		}
	}

	char *getDiskUsage(char *disk) {
		char command[111] = "disk=";
		strcat(command, disk);
		strcat(command, " && df -h --output=target,source,pcent | grep $disk | sed -e 's/ //g' -e 's/\\/dev\\/'\"$disk\"'/: /'");
		FILE *dfStdout = popen(command, "r");
		char *usage = fgets(buffer, sizeof(buffer), dfStdout);
		pclose(dfStdout);
		usage[strlen(usage)-1] = '\0';
		return usage;
	}

	int testDiskUsage(char *disk) {
		char command[103] = "disk=";
		strcat(command, disk);
		strcat(command, " && df -h --output=pcent,source | grep $disk | sed -e 's/ //g' -e 's/%\\/dev\\/'\"$disk\"'//'");
		FILE *dfStdout = popen(command, "r");
		char *usage = fgets(buffer, sizeof(buffer), dfStdout);
		pclose(dfStdout);
		if(strlen(usage)==3 && (int)usage[0]<55) {
			return 0;
		}
		else { if(strlen(usage)==2) {
			return 0;
		}
		else { if(strlen(usage)==3 && (int)usage[0]>=55 && (int)usage[0]<57) {
			return 1;
		}
		else {
			return 2;
		}}}
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

	void display(char *prefix, char *data, int priority, int last) {
		char jsonStr[128] = "{\"full_text\":\"";
		strcat(jsonStr, prefix);
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
	display("IP Publique: ", getPublicIp(), 0, 0);
	display("", getDiskUsage("sda6"), testDiskUsage("sda6"), 0);
	display("", getDiskUsage("sda7"), testDiskUsage("sda7"), 0);
	display("", getDiskUsage("sda8"), testDiskUsage("sda8"), 0);
	display("", getDiskUsage("sda9"), testDiskUsage("sda9"), 0);
	display("", getDiskUsage("sda10"), testDiskUsage("sda10"), 0);
	display("", getDate(), 0, 0);
	display("", getVolume(), testVolumeState(), 0);
	display("", "", 0, 1);
	puts("],");

	return 0;
}
