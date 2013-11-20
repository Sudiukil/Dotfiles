#include <stdio.h>
#include <string.h>

char buffer[256];

#include "src/time.h"
#include "src/volume.h"
#include "src/disk.h"
#include "src/battery.h"
#include "src/publicip.h"
#include "src/moc.h"
#include "src/display.h"

int main(void) {
	printf("[");
	//display("MOC: ", getMocInfos(testMocState()), 0, 0);
	//display("IP Publique: ", getPublicIp(), 0, 0);
	//display("", getDiskUsage("sda6"), testDiskUsage("sda6"), 0);
	//display("", getDiskUsage("sda7"), testDiskUsage("sda7"), 0);
	//display("", getDiskUsage("sda8"), testDiskUsage("sda8"), 0);
	//display("", getDiskUsage("sda9"), testDiskUsage("sda9"), 0);
	//display("", getDiskUsage("sda10"), testDiskUsage("sda10"), 0);
	//display("", getBattery(), testBatteryPcent(), 0);
	display("", getTime(), 0, 0);
	display("", getVolume(), testVolumeState(),1);
	printf("],");

	return 0;
}
