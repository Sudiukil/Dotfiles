#include <stdio.h>
#include <string.h>

char buffer[256]; //buffer to get the shell commands standard output

char *getDate() {
	FILE *dateStdout = popen("date \"+%d/%m/%Y - %H:%M:%S\"", "r"); //getting de standard output of shell command...
	char *date = fgets(buffer, sizeof(buffer), dateStdout); //... and putting it in a char* using the buffer
	pclose(dateStdout); //closing the standard output "file"
	date[strlen(date)-1] = '\0'; //removing the last annoying line break of the string
	return date;
}

char *getVolume() {
	FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 2 | sed -e 's/ //g' -e 's/]//'", "r");
	char *volume = fgets(buffer, sizeof(buffer), amixerStdout);
	pclose(amixerStdout);
	volume[strlen(volume)-1] = '\0';
	return volume;
}

int testVolumeState() { //testing the volume state (muted or not) to define the display color of the volume percent
	FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 4 | sed -e 's/on]/1/' -e 's/off]/0/'", "r");
	char *state = fgets(buffer, sizeof(buffer), amixerStdout);
	pclose(amixerStdout);
	if(state[0]=='1') return 0;
	else return 1;
}

char *getBattery() {
	FILE *acpiStdout = popen("acpi -b | cut -d ' ' -f 3,4,5 | sed -e 's/Charging,/CHR:/' -e 's/Discharging,/BAT:/' -e 's/,//g'", "r");
	char *battery = fgets(buffer, sizeof(buffer), acpiStdout);
	pclose(acpiStdout);
	battery[strlen(battery)-1] = '\0';
	return battery;
}

int testBatteryPcent() { //same goal than testVolumeState()
	FILE *acpiStdout = popen("acpi -b | cut -d ' ' -f 4 | sed -e 's/%,//'", "r");
	char *pcent = fgets(buffer, sizeof(buffer), acpiStdout);
	pclose(acpiStdout);
	if(strlen(pcent)==3) {
		if((int)pcent[0]>=52 && (int)pcent[0]<56) return 0;
		else if((int)pcent[0]<52) return 1;
		else if((int)pcent[0]>=56) return 1;
		else return 2;
	}
	else return 2;
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

int testDiskUsage(char *disk) { //same goal than testVolumeState and testBatteryPcent
	char command[103] = "disk=";
	strcat(command, disk);
	strcat(command, " && df -h --output=pcent,source | grep $disk | sed -e 's/ //g' -e 's/%\\/dev\\/'\"$disk\"'//'");
	FILE *dfStdout = popen(command, "r");
	char *usage = fgets(buffer, sizeof(buffer), dfStdout);
	pclose(dfStdout);
	if(strlen(usage)==3) {
		if((int)usage[0]<55) return 0;
		else if((int)usage[0]>=55 && (int)usage[0]<57) return 1;
		else return 2;
	}
	else if(strlen(usage)==2) return 0;
	else return 2;
}

char *getPublicIp() {
	FILE *curlStdout = popen("curl -s 192.168.1.1 | grep \"90.\" | cut -d '>' -f 2 | cut -d '<' -f 1", "r");
	char *publicIp = fgets(buffer, sizeof(buffer), curlStdout);
	pclose(curlStdout);
	publicIp[strlen(publicIp)-1] = '\0';
	return publicIp;
}

int testMocState() { //check if MOC is running
	FILE *psStdout = popen("ps -e | grep mocp > /dev/null; echo $?", "r");
	char *returnCode = fgets(buffer, sizeof(buffer), psStdout);
	pclose(psStdout);
	if(returnCode[0]=='0') return 0;
	else return 1;
}

char *getMocInfos(int returnCode) { //get infos from MOC only if it's running
	if(returnCode==0) {
		char command[46] = "mocp -Q %state:\\ %title\\ %ct\\/%tl\\ \\[%tt]";
		FILE *mocpStdout = popen(command, "r");
		char *infos = fgets(buffer, sizeof(buffer), mocpStdout);
		pclose(mocpStdout);
		if(infos[0]=='S') return "STOP";
		else {
			infos[strlen(infos)-1] = '\0';
			return infos;
		}
	}
	else return "STOP";
}

void display(char *prefix, char *data, int priority, int last) { //append json parts, a prefix and a facultative color to a string and print it
	char jsonStr[128] = "{\"full_text\":\"";
	strcat(jsonStr, prefix);
	strcat(jsonStr, data);
	switch(priority) {
		case 0: //dont colorize the output
			strcat(jsonStr, "\"}");
			break;
		case 1: //colorize in yellow
			strcat(jsonStr, "\",\"color\":\"#ffff00\"}");
			break;
		case 2: //colorize in red
			strcat(jsonStr, "\",\"color\":\"#ff0000\"}");
			break;
	}
	if(last==0) strcat(jsonStr, ",");
	printf("%s", jsonStr);
}

int main(int argc, char **argv) {

	puts("[");
	//display("MOC: ", getMocInfos(testMocState()), 0, 0);
	//display("IP Publique: ", getPublicIp(), 0, 0);
	//display("", getDiskUsage("sda6"), testDiskUsage("sda6"), 0);
	//display("", getDiskUsage("sda7"), testDiskUsage("sda7"), 0);
	//display("", getDiskUsage("sda8"), testDiskUsage("sda8"), 0);
	//display("", getDiskUsage("sda9"), testDiskUsage("sda9"), 0);
	//display("", getDiskUsage("sda10"), testDiskUsage("sda10"), 0);
	//display("", getBattery(), testBatteryPcent(), 0);
	display("", getDate(), 0, 0);
	display("", getVolume(), testVolumeState(),0);
	display("", "", 0, 1);
	puts("],");

	return 0;
}
