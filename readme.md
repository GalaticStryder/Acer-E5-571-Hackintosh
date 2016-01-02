Mac OS X on the Acer Aspire E5-571-376T
==========================

A place for patches that allow booting OSX in the Acer E5-571-376T. Fow now, this repo is under construction (maybe forever), it'll take some time to get something decent as I'm newbie on it (GNU/Linux guy).

Hardware
-------------------------

You'll find all hardware related stuff in **information** folder. The basic hardware information about the main laptop components are the following:

- Intel Core i3-5005U
- Intel Graphics HD5500
- [Intel 9 Series Chipset](http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/9-series-chipset-pch-datasheet.pdf)
  - Wildcat Point-LP SATA Controller [AHCI Mode]
  - Wildcat Point-LP High Definition Audio Controller
  - Wildcat Point-LP USB xHCI Controller
  - Wildcat Point-LP LPC Controller
  - Wildcat Point-LP SMBus Controller
  - Wildcat Point-LP Thermal Management Controller
  - More...
- Atheros AR3012 Bluetooth
- Realtek RTL8111/8168/8411 Ethernet Controller
- QCA9565 / AR9565 Wireless Network Adapter

Instructions
-------------------------

Proccess to extract DSTD from GNU/Linux:

        mkdir ascpi-tables
        sudo cp -R /sys/firmware/acpi/tables ascpi-tables
        sudo chmod -R ugo+rw ascpi-tables
        sudo chown -R galatic ascpi-tables

Doing this way we avoid permission problems by making it read/write able by anyone. Also, this changes from root to my user the ownership, just in case.

To rename the files I've just adapted RehabMan's script to my ascpi-tables folder, now it contains one DSDT and a nine SSDTs, as mentioned they were all extracted from a GNU/Linux distribution (Ubuntu 15.10) with Linux kernel 4.1.

