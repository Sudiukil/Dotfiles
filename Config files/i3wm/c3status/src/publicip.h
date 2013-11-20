char *getPublicIp() {
	FILE *curlStdout = popen("curl -s 192.168.1.1 | grep \"90.\" | cut -d '>' -f 2 | cut -d '<' -f 1", "r");
	fgets(buffer, sizeof(buffer), curlStdout);
	pclose(curlStdout);
	buffer[strlen(buffer)-1] = '\0';
	return buffer;
}

int testMocState() {
	FILE *psStdout = popen("ps -e | grep mocp > /dev/null; echo $?", "r");
	fgets(buffer, sizeof(buffer), psStdout);
	pclose(psStdout);
	if(buffer[0]=='0') return 0;
	else return 1;
}
