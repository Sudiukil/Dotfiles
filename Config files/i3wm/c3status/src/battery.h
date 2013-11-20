char *getBattery() {
	FILE *acpiStdout = popen("acpi -b | cut -d ' ' -f 3,4,5 | sed -e 's/Charging,/CHR:/' -e 's/Discharging,/BAT:/' -e 's/,//g'", "r");
	fgets(buffer, sizeof(buffer), acpiStdout);
	pclose(acpiStdout);
	buffer[strlen(buffer)-1] = '\0';
	return buffer;
}

int testBatteryPcent() {
	FILE *acpiStdout = popen("acpi -b | cut -d ' ' -f 4 | sed -e 's/%,//'", "r");
	fgets(buffer, sizeof(buffer), acpiStdout);
	pclose(acpiStdout);
	if(strlen(buffer)==3) {
		if((int)buffer[0]>=52 && (int)buffer[0]<56) return 0;
		else if((int)buffer[0]<52) return 1;
		else if((int)buffer[0]>=56) return 1;
		else return 2;
	}
	else return 2;
}
