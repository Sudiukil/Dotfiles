char *getDiskUsage(char *disk) {
	char command[111] = "disk=";
	strcat(command, disk);
	strcat(command, " && df -h --output=target,source,pcent | grep $disk | sed -e 's/ //g' -e 's/\\/dev\\/'\"$disk\"'/: /'");
	FILE *dfStdout = popen(command, "r");
	fgets(buffer, sizeof(buffer), dfStdout);
	pclose(dfStdout);
	buffer[strlen(buffer)-1] = '\0';
	return buffer;
}

int testDiskUsage(char *disk) {
	char command[103] = "disk=";
	strcat(command, disk);
	strcat(command, " && df -h --output=pcent,source | grep $disk | sed -e 's/ //g' -e 's/%\\/dev\\/'\"$disk\"'//'");
	FILE *dfStdout = popen(command, "r");
	fgets(buffer, sizeof(buffer), dfStdout);
	pclose(dfStdout);
	if(strlen(buffer)==3) {
		if((int)buffer[0]<55) return 0;
		else if((int)buffer[0]>=55 && (int)buffer[0]<57) return 1;
		else return 2;
	}
	else if(strlen(buffer)==2) return 0;
	else return 2;
}
