Mac OS X on the Acer Aspire E5-571-376T
==========================

![Acer Aspire E5-571-376T](http://static.acer.com/up/Resource/Acer/Notebooks/AGW2%20Aspire%20E/Images/20140325/Aspire_E5-571-531-551-521-511_nontouch_black_glare-sku-main.png)

A place/guide for patches that allow booting OSX in the Acer E5-571-376T. Fow now, this repo is under construction (maybe forever), it'll take some time to get something decent as I'm newbie on it (GNU/Linux guy).
All the processes are generically the same for a hackintosh laptop build (Intel), but DSDT/SSDT patching and some more specific things like kexts and stuff should be device/board particular.

**Note:** Board refers to Brodwell, Haswell, Ivy Bridge...

Notice that I'm not gonna teach someone "how to", there are many places on forums to get every guide you need. If you don't know what are the steps for your model, please checkout tonymac's website/forum and **read** the guides and threads for El Capitan Laptop support.

As for Acer laptops, notice that this is one of a thousand other models, any minimal difference might get you a laptop that doesn't boot or even brick it depending on what mess you gonna be doing. That's why I encourage you to **not** follow this guide as a reference for now, even with the same model. If you want to mess around as well... go for it the, I advised.

Environment
-------------------------

I've got two machines to do this job:

- Target **Acer E5-571-376T** laptop running Ubuntu 15.10 in UEFI mode
- A desktop computer running Mac OSX as guest in VirtualBox being hosted by Arch Linux

To get a decente performance on the guest O.S. you must set 256MB of VRAM for your Mac V.M. trough the .vdi file and use **beamoff** app on startup. Resolution fix can easily be found at a Google search.

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

Before going anywhere else, please, check you laptop model twice.
Confirmed it is the same as stated in the repository or close a one? Then, you can step forward.

**Warning:** This repository wants to bring the most automated proccess of hacking a laptop, all scripts and everything in here was meant to be here in this repository. Read **environment** back again to get a better approach over the setup I use.

**Warning:** Use the clean.sh script in this folder to start doing your own hackintosh from scratch in case it's not the **same** E5-571-**346T**, and don't forget to check **all** specs to see what matches and what doesn't, i.e.: CPU must be a Broadwell one, this spec is our north. Although generating you own DSDT is recommended. If it's not you should get another guide that better matches your hardware (CPU/GPU generation mainly).

Proccess to extract DSTD from GNU/Linux:

	mkdir dsdt
	cd dsdt
	mkdir original
	sudo cp -R /sys/firmware/acpi/tables original
	sudo chmod -R ugo+rw original
	sudo chown -R galatic original

Doing this way we avoid permission problems by making it read/write able by anyone. Also, this changes from root to my user the ownership, just in case.

To rename the files I've just adapted RehabMan's script to my original folder, now it contains one DSDT and a nine SSDTs, as mentioned they were all extracted from a GNU/Linux distribution (Ubuntu 15.10) with Linux kernel 4.1.


