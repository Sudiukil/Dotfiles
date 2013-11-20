#include <time.h>

char *getTime() {
	time_t timestamp = time(NULL);
	strftime(buffer, sizeof(buffer), "%d/%m/%Y - %H:%M:%S", localtime(&timestamp));
	return buffer;
}
