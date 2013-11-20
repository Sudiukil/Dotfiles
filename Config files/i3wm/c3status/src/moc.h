char *getMocInfos(int returnCode) {
	if(returnCode==0) {
		char command[46] = "mocp -Q %state:\\ %title\\ %ct\\/%tl\\ \\[%tt]";
		FILE *mocpStdout = popen(command, "r");
		fgets(buffer, sizeof(buffer), mocpStdout);
		pclose(mocpStdout);
		if(buffer[0]=='S') return "STOP";
		else {
			buffer[strlen(buffer)-1] = '\0';
			return buffer;
		}
	}
	else return "STOP";
}
