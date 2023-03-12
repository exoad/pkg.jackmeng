/**
 * Copyright 2023 Jack Meng. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
#include <stdlib.h>

int get_cpu_usage() {
    FILE* fp;
    char buf[256];
    int user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice;
    int total_time, idle_time;
    float usage;

    fp = fopen("/proc/stat", "r");
    if (fp == NULL) {
        return -1;
    }

    fgets(buf, sizeof(buf), fp);
    fclose(fp);

    sscanf(buf, "cpu %d %d %d %d %d %d %d %d %d %d",
           &user, &nice, &system, &idle, &iowait, &irq, &softirq, &steal, &guest, &guest_nice);

    total_time = user + nice + system + idle + iowait + irq + softirq + steal;
    idle_time = idle + iowait;

    usage = ((float)(total_time - idle_time) / (float)total_time) * 100.0;
    return (int)usage;
}