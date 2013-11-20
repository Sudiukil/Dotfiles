void display(char *prefix, char *data, int priority, int last) {
	char jsonStr[256] = "{\"full_text\":\"";
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
	if(last==0) strcat(jsonStr, ",");
	printf("%s", jsonStr);
}
