char *getVolume() {
	FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 2 | sed -e 's/ //g' -e 's/]//'", "r");
	fgets(buffer, sizeof(buffer), amixerStdout);
	pclose(amixerStdout);
	buffer[strlen(buffer)-1] = '\0';
	return buffer;
}

int testVolumeState() {
	FILE *amixerStdout = popen("amixer get Master | grep \"Mono:\" | cut -d '[' -f 4 | sed -e 's/on]/1/' -e 's/off]/0/'", "r");
	fgets(buffer, sizeof(buffer), amixerStdout);
	pclose(amixerStdout);
	if(buffer[0]=='1') return 0;
	else return 1;
}
